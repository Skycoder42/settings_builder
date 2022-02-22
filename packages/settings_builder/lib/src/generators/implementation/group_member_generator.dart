// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../annotation_readers/settings_group_reader.dart';
import '../../annotations.dart';
import '../../extensions/element_x.dart';
import '../../signatures.dart';

@internal
class GroupMemberGenerator {
  final PropertyAccessorElement getter;
  final SettingsGroupReader selfSettingsGroup;
  final SettingsGroupReader getterSettingsGroup;

  GroupMemberGenerator({
    required this.getter,
    required this.selfSettingsGroup,
    required this.getterSettingsGroup,
  });

  void build(ClassBuilder b) {
    if (getter.returnType.nullabilitySuffix == NullabilitySuffix.question) {
      throw InvalidGenerationSourceError(
        'Sub-Group getters must not be nullable.',
        element: getter,
      );
    }

    final settingsEntry = SettingsEntryReader(
      getter.getAnnotation(const TypeChecker.fromRuntime(SettingsEntry)),
    );

    b.fields.add(_buildGetter(settingsEntry));
  }

  Field _buildGetter(SettingsEntryReader settingsEntry) => Field(
        (b) => b
          ..name = getter.name
          ..modifier = FieldModifier.final$
          ..late = true
          ..annotations.add(Annotations.override)
          ..assignment = InvokeExpression.newOf(
            TypeReference(
              (b) => b.symbol = Signatures.impl(getter.returnType.element!),
            ),
            [
              Signatures.sharedPreferencesRef,
              _buildKey(settingsEntry),
            ],
          ).code,
      );

  Expression _buildKey(SettingsEntryReader settingsEntry) {
    final entryKey = settingsEntry.key ?? getter.name;
    if (selfSettingsGroup.root) {
      return Signatures.prefixRef.notEqualTo(literalNull).conditional(
            literalString('\$${Signatures.prefix}.$entryKey'),
            literalString(entryKey),
          );
    } else {
      return literalString('\$${Signatures.groupKey}.$entryKey');
    }
  }
}
