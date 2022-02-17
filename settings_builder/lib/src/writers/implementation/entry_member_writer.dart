// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_helper/source_helper.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../annotation_readers/settings_group_reader.dart';
import '../../extensions.dart';
import '../mixin/mixin_writer.dart';
import '../writer.dart';
import 'entry_getter_writer.dart';
import 'implementation_writer.dart';

@internal
class EntryMemberWriter implements Writer {
  final PropertyAccessorElement getter;
  final SettingsGroupReader settingsGroup;

  String get getterKeyName => '${getter.name}Key';
  String get hasGetterName => 'has${getter.name.pascal}';

  EntryMemberWriter({
    required this.getter,
    required this.settingsGroup,
  });

  @override
  void call(StringBuffer buffer) {
    final settingsEntry = SettingsEntryReader(
      getter.getAnnotation<SettingsEntry>(),
    );

    _writeKey(buffer, settingsEntry);
    _writeHasValue(buffer, settingsEntry);
    EntryGetterWriter(
      getter: getter,
      settingsEntry: settingsEntry,
      getterKeyName: getterKeyName,
    )(buffer);
  }

  void _writeKey(StringBuffer buffer, SettingsEntryReader settingsEntry) {
    final entryKey = settingsEntry.key ?? getter.name;

    buffer
      ..writeln('@override')
      ..write('late final $getterKeyName = ');

    if (settingsGroup.root) {
      buffer.writeln(
        '${ImplementationWriter.prefixKey} != null '
        "? '\$${ImplementationWriter.prefixKey}.$entryKey' "
        ": '$entryKey';",
      );
    } else {
      buffer.writeln("'\$${MixinWriter.groupKeyName}.$entryKey';");
    }

    buffer.writeln();
  }

  void _writeHasValue(StringBuffer buffer, SettingsEntryReader settingsEntry) {
    buffer
      ..writeln('@override')
      ..writeln(
        'bool get $hasGetterName => '
        '${ImplementationWriter.spKey}.containsKey($getterKeyName);',
      )
      ..writeln();
  }
}
