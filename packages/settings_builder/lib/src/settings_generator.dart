import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation_readers/settings_group_reader.dart';
import 'generators/implementation/implementation_generator.dart';
import 'generators/mixin/mixin_generator.dart';

@internal
class SettingsGenerator extends GeneratorForAnnotation<SettingsGroup> {
  static const groupKeyName = 'groupKey';

  final BuilderOptions builderOptions;

  const SettingsGenerator(this.builderOptions);

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final generatedCode = await super.generate(library, buildStep);

    if (generatedCode.isEmpty) {
      return generatedCode;
    }

    final buffer = StringBuffer()
      ..writeln('// ignore_for_file: avoid_positional_boolean_parameters')
      ..writeln()
      ..write(generatedCode);
    return buffer.toString();
  }

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
    final mixinGenerator = MixinGenerator(
      clazz: element,
      settingsGroup: settingsGroup,
    );
    final implementationGenerator = ImplementationGenerator(
      clazz: element,
      settingsGroup: settingsGroup,
    );

    final emitter = DartEmitter(
      orderDirectives: true,
      useNullSafetySyntax: true,
    );

    final buffer = StringBuffer();
    mixinGenerator.build().accept(emitter, buffer);
    implementationGenerator.build().accept(emitter, buffer);
    return buffer.toString();
  }
}
