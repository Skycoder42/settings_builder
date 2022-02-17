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
import 'entry_setter_writer.dart';
import 'implementation_writer.dart';

@internal
class EntryMemberWriter implements Writer {
  final PropertyAccessorElement getter;
  final SettingsGroupReader settingsGroup;

  String get entryKeyName => '${getter.name}Key';
  String get hasEntryName => 'has${getter.name.pascal}';

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
    buffer.writeln();
    _writeHasValue(buffer, settingsEntry);
    buffer.writeln();
    EntryGetterWriter(
      getter: getter,
      settingsEntry: settingsEntry,
      entryKeyName: entryKeyName,
    )(buffer);
    buffer.writeln();
    EntrySetterWriter(
      getter: getter,
      settingsEntry: settingsEntry,
      entryKeyName: entryKeyName,
    )(buffer);
    buffer.writeln();
  }

  void _writeKey(StringBuffer buffer, SettingsEntryReader settingsEntry) {
    final entryKey = settingsEntry.key ?? getter.name;

    buffer
      ..writeln('@override')
      ..write('late final $entryKeyName = ');

    if (settingsGroup.root) {
      buffer.writeln(
        '${ImplementationWriter.prefixKey} != null '
        "? '\$${ImplementationWriter.prefixKey}.$entryKey' "
        ": '$entryKey';",
      );
    } else {
      buffer.writeln("'\$${MixinWriter.groupKeyName}.$entryKey';");
    }
  }

  void _writeHasValue(StringBuffer buffer, SettingsEntryReader settingsEntry) {
    buffer
      ..writeln('@override')
      ..writeln(
        'bool get $hasEntryName => '
        '${ImplementationWriter.spKey}.containsKey($entryKeyName);',
      );
  }
}
