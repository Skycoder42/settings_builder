// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';

import '../../annotation_readers/settings_group_reader.dart';
import '../../extensions.dart';
import '../mixin/mixin_writer.dart';
import '../writer.dart';
import 'entry_member_writer.dart';

@internal
class ImplementationWriter implements Writer {
  static const prefixKey = 'prefix';
  static const spKey = '_sharedPreferences';

  final ClassElement clazz;
  final SettingsGroupReader settingsGroup;

  String get implementationName => '_\$${clazz.name}Impl';

  ImplementationWriter({
    required this.clazz,
    required this.settingsGroup,
  });

  @override
  void call(StringBuffer buffer) {
    buffer.writeln('class $implementationName implements ${clazz.name} {');

    _writeCommon(buffer);

    for (final getter in clazz.abstractGetters) {
      if (getter.returnType.hasAnnotation<SettingsGroup>()) {
      } else {
        EntryMemberWriter(
          getter: getter,
          settingsGroup: settingsGroup,
        )(buffer);
      }
    }

    buffer.writeln('} // $implementationName');
  }

  void _writeCommon(StringBuffer buffer) {
    buffer
      ..writeln('final SharedPreferences $spKey;')
      ..writeln();

    if (settingsGroup.root) {
      _writeRootCommon(buffer);
    } else {
      _writeGroupCommon(buffer);
    }
  }

  void _writeRootCommon(StringBuffer buffer) => buffer
    ..writeln('@override')
    ..writeln('final String? $prefixKey;')
    ..writeln();

  void _writeGroupCommon(StringBuffer buffer) => buffer
    ..writeln('@override')
    ..writeln('final String ${MixinWriter.groupKeyName};')
    ..writeln();
}
