// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_group_reader.dart';
import '../../annotations.dart';
import '../../extensions/dart_type_x.dart';
import '../../extensions/element_x.dart';
import '../../signatures.dart';
import '../../types.dart';
import 'entry_member_generator.dart';
import 'group_member_generator.dart';

@internal
class ImplementationGenerator {
  final ClassElement clazz;
  final SettingsGroupReader settingsGroup;

  String get implementationName => Signatures.impl(clazz);

  ImplementationGenerator({
    required this.clazz,
    required this.settingsGroup,
  });

  Class build() => Class((b) {
        b
          ..name = implementationName
          ..implements.add(clazz.typeReference);

        _buildCommon(b);

        for (final getter in clazz.abstractGetters(
          includeSuperclass: settingsGroup.includeSuperclass,
        )) {
          final getterSettingsGroup = getter.returnType
              .getAnnotation(const TypeChecker.fromRuntime(SettingsGroup));
          if (getterSettingsGroup.isNull) {
            EntryMemberGenerator(
              getter: getter,
              settingsGroup: settingsGroup,
            ).build(b);
          } else {
            GroupMemberGenerator(
              getter: getter,
              selfSettingsGroup: settingsGroup,
              getterSettingsGroup: SettingsGroupReader(getterSettingsGroup),
            ).build(b);
          }
        }
      });

  void _buildCommon(ClassBuilder b) {
    b.fields.add(
      Field(
        (b) => b
          ..name = Signatures.sharedPreferences
          ..modifier = FieldModifier.final$
          ..type = Types.sharedPreferences,
      ),
    );

    if (settingsGroup.root) {
      _buildRootCommon(b);
    } else {
      _buildGroupCommon(b);
    }
  }

  void _buildRootCommon(ClassBuilder b) {
    b
      ..fields.add(
        Field(
          (b) => b
            ..name = Signatures.prefix
            ..modifier = FieldModifier.final$
            ..type = Types.nullableString
            ..annotations.add(Annotations.override),
        ),
      )
      ..constructors.add(
        Constructor(
          (b) => b
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..toThis = true
                  ..name = Signatures.sharedPreferences,
              ),
            )
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..toThis = true
                  ..name = Signatures.prefix,
              ),
            ),
        ),
      )
      ..methods.addAll([
        Method(
          (b) => b
            ..static = true
            ..name = Signatures.getInstance
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..name = Signatures.prefix
                  ..type = Types.nullableString,
              ),
            )
            ..modifier = MethodModifier.async
            ..returns = Types.future(clazz.typeReference)
            ..lambda = true
            ..body = InvokeExpression.newOf(
              Reference(implementationName),
              [
                Types.sharedPreferences
                    .property('getInstance')
                    .call(const []).awaited,
                Signatures.prefixRef,
              ],
            ).code,
        ),
        Method(
          (p) => p
            ..name = Signatures.clear
            ..returns = Types.futureBool
            ..annotations.add(Annotations.override)
            ..body = Signatures.sharedPreferencesRef
                .property('clear')
                .call(const []).code,
        ),
        Method(
          (p) => p
            ..name = Signatures.reload
            ..returns = Types.futureVoid
            ..annotations.add(Annotations.override)
            ..body = Signatures.sharedPreferencesRef
                .property('reload')
                .call(const []).code,
        ),
      ]);
  }

  void _buildGroupCommon(ClassBuilder b) {
    b
      ..fields.add(
        Field(
          (b) => b
            ..name = Signatures.groupKey
            ..modifier = FieldModifier.final$
            ..type = Types.string
            ..annotations.add(Annotations.override),
        ),
      )
      ..constructors.add(
        Constructor(
          (b) => b
            ..requiredParameters.addAll([
              Parameter(
                (b) => b
                  ..toThis = true
                  ..name = Signatures.sharedPreferences,
              ),
              Parameter(
                (b) => b
                  ..toThis = true
                  ..name = Signatures.groupKey,
              ),
            ]),
        ),
      );
  }
}
