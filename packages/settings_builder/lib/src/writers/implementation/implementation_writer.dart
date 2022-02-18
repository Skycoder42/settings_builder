// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_group_reader.dart';
import '../../extensions/dart_type_x.dart';
import '../../extensions/element_x.dart';
import '../mixin/mixin_writer.dart';
import '../writer.dart';
import 'entry_member_writer.dart';
import 'group_member_writer.dart';

@internal
class ImplementationWriter implements Writer {
  static const prefixKey = 'prefix';
  static const spKey = '_sharedPreferences';

  final ClassElement clazz;
  final SettingsGroupReader settingsGroup;

  static String getImplementationName(Element clazz) => '_\$${clazz.name}Impl';

  String get implementationName => getImplementationName(clazz);

  ImplementationWriter({
    required this.clazz,
    required this.settingsGroup,
  });

  @override
  void call(StringBuffer buffer) {
    buffer.writeln('class $implementationName implements ${clazz.name} {');

    _writeCommon(buffer);

    for (final getter in clazz.abstractGetters(
      includeSuperclass: settingsGroup.includeSuperclass,
    )) {
      final getterSettingsGroup = getter.returnType
          .getAnnotation(const TypeChecker.fromRuntime(SettingsGroup));
      if (getterSettingsGroup.isNull) {
        EntryMemberWriter(
          getter: getter,
          settingsGroup: settingsGroup,
        )(buffer);
      } else {
        GroupMemberWriter(
          getter: getter,
          selfSettingsGroup: settingsGroup,
          getterSettingsGroup: SettingsGroupReader(getterSettingsGroup),
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
    ..writeln()
    ..writeln('$implementationName(this.$spKey, [this.$prefixKey]);')
    ..writeln()
    ..writeln(
      'static Future<${clazz.name}> '
      'getInstance([String? $prefixKey]) async => '
      '$implementationName(await SharedPreferences.getInstance(), $prefixKey);',
    )
    ..writeln()
    ..writeln('@override')
    ..writeln('Future<bool> clear() => $spKey.clear();')
    ..writeln();

  void _writeGroupCommon(StringBuffer buffer) => buffer
    ..writeln('@override')
    ..writeln('final String ${MixinWriter.groupKeyName};')
    ..writeln()
    ..writeln(
      '$implementationName(this.$spKey, this.${MixinWriter.groupKeyName});',
    )
    ..writeln();
}
