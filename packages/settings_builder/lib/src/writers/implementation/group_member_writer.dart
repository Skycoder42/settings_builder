// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../annotation_readers/settings_group_reader.dart';
import '../../extensions/element_x.dart';
import '../mixin/mixin_writer.dart';
import '../writer.dart';
import 'implementation_writer.dart';

@internal
class GroupMemberWriter implements Writer {
  final PropertyAccessorElement getter;
  final SettingsGroupReader selfSettingsGroup;
  final SettingsGroupReader getterSettingsGroup;

  GroupMemberWriter({
    required this.getter,
    required this.selfSettingsGroup,
    required this.getterSettingsGroup,
  });

  @override
  void call(StringBuffer buffer) {
    if (getter.returnType.nullabilitySuffix == NullabilitySuffix.question) {
      throw InvalidGenerationSourceError(
        'Sub-Group getters must not be nullable.',
        element: getter,
      );
    }

    final settingsEntry = SettingsEntryReader(
      getter.getAnnotation(const TypeChecker.fromRuntime(SettingsEntry)),
    );

    _writeGetter(buffer, settingsEntry);
    buffer.writeln();
  }

  void _writeGetter(StringBuffer buffer, SettingsEntryReader settingsEntry) {
    final implementationName = ImplementationWriter.getImplementationName(
      getter.returnType.element!,
    );

    buffer
      ..writeln('@override')
      ..writeln('late final ${getter.name} = $implementationName(')
      ..writeln('${ImplementationWriter.spKey},');
    _writeKey(buffer, settingsEntry);
    buffer.writeln(');');
  }

  void _writeKey(StringBuffer buffer, SettingsEntryReader settingsEntry) {
    final entryKey = settingsEntry.key ?? getter.name;

    if (selfSettingsGroup.root) {
      buffer.write(
        '${ImplementationWriter.prefixKey} != null '
        "? '\$${ImplementationWriter.prefixKey}.$entryKey' "
        ": '$entryKey',",
      );
    } else {
      buffer.write("'\$${MixinWriter.groupKeyName}.$entryKey',");
    }
  }
}
