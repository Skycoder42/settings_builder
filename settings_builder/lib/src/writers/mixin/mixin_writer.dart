// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_group_reader.dart';
import '../../extensions.dart';
import '../writer.dart';
import 'member_writer.dart';

@internal
class MixinWriter implements Writer {
  static const groupKeyName = 'key';

  final ClassElement clazz;
  final SettingsGroupReader settingsGroup;

  String get mixinName => '_\$${clazz.name}';

  const MixinWriter({
    required this.clazz,
    required this.settingsGroup,
  });

  @override
  void call(StringBuffer buffer) {
    buffer.writeln('mixin $mixinName {');

    if (settingsGroup.root) {
      _writeRootCommon(buffer);
    } else {
      _writeGroupCommon(buffer);
    }

    for (final getter in clazz.abstractGetters) {
      if (!getter.returnType
          .getAnnotation(const TypeChecker.fromRuntime(SettingsGroup))
          .isNull) {
        // skip sub groups
        continue;
      }

      MemberWriter(getter: getter)(buffer);
    }

    buffer.writeln('} // $mixinName');
  }

  void _writeRootCommon(StringBuffer buffer) => buffer
    ..writeln('String? get prefix;')
    ..writeln()
    ..writeln('Future<bool> clear();')
    ..writeln();

  void _writeGroupCommon(StringBuffer buffer) => buffer
    ..writeln('String get $groupKeyName;')
    ..writeln();
}
