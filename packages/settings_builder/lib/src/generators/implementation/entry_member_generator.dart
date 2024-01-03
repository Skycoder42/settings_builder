import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../annotation_readers/settings_group_reader.dart';
import '../../annotations.dart';
import '../../extensions/element_x.dart';
import '../../signatures.dart';
import '../../types.dart';
import 'entry_getter_generator.dart';
import 'entry_setter_generator.dart';

@internal
class EntryMemberGenerator {
  final PropertyAccessorElement getter;
  final SettingsGroupReader settingsGroup;

  EntryMemberGenerator({
    required this.getter,
    required this.settingsGroup,
  });

  void build(ClassBuilder b) {
    final settingsEntry = SettingsEntryReader(
      getter.getAnnotation(const TypeChecker.fromRuntime(SettingsEntry)),
    );

    b
      ..fields.add(_buildKey(settingsEntry))
      ..methods.addAll([
        _buildHasValue(settingsEntry),
        EntryGetterGenerator(
          getter: getter,
          settingsEntry: settingsEntry,
        ).build(),
        EntrySetterGenerator(
          getter: getter,
          settingsEntry: settingsEntry,
        ).build(),
        _buildRemove(),
      ]);
  }

  Field _buildKey(SettingsEntryReader settingsEntry) => Field(
        (b) {
          b
            ..name = Signatures.entryKey(getter)
            ..modifier = FieldModifier.final$
            ..late = true
            ..annotations.add(Annotations.override);

          final entryKey = settingsEntry.key ?? getter.name;
          if (settingsGroup.root) {
            b.assignment = Signatures.prefixRef
                .notEqualTo(literalNull)
                .conditional(
                  literalString(
                    '\$${Signatures.prefix}.$entryKey',
                  ),
                  literalString(entryKey),
                )
                .code;
          } else {
            b.assignment = literalString(
              '\$${Signatures.groupKey}.$entryKey',
            ).code;
          }
        },
      );

  Method _buildHasValue(SettingsEntryReader settingsEntry) => Method(
        (b) => b
          ..type = MethodType.getter
          ..name = Signatures.hasEntry(getter)
          ..returns = Types.boolean
          ..annotations.add(Annotations.override)
          ..lambda = true
          ..body = Signatures.sharedPreferencesRef
              .property('containsKey')
              .call([Signatures.entryKeyRef(getter)]).code,
      );

  Method _buildRemove() => Method(
        (b) => b
          ..name = Signatures.removeEntry(getter)
          ..returns = Types.futureBool
          ..annotations.add(Annotations.override)
          ..lambda
          ..body = Signatures.sharedPreferencesRef
              .property('remove')
              .call([Signatures.entryKeyRef(getter)]).code,
      );
}
