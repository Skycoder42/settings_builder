// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation_readers/settings_group_reader.dart';
import 'writers/implementation/implementation_writer.dart';
import 'writers/mixin/mixin_writer.dart';

@internal
class SettingsGenerator extends GeneratorForAnnotation<SettingsGroup> {
  static const groupKeyName = 'groupKey';

  final BuilderOptions builderOptions;

  const SettingsGenerator(this.builderOptions);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'The $SettingsGroup annotation can only be used on classes',
        element: element,
      );
    }

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError(
        'The $SettingsGroup annotation can only be used on abstract classes',
        element: element,
      );
    }

    final settingsGroup = SettingsGroupReader(annotation);
    final mixinWriter = MixinWriter(
      clazz: element,
      settingsGroup: settingsGroup,
    );
    final implementationWriter = ImplementationWriter(
      clazz: element,
      settingsGroup: settingsGroup,
    );

    final buffer = StringBuffer();
    mixinWriter(buffer);
    implementationWriter(buffer);
    return buffer.toString();
  }
}
