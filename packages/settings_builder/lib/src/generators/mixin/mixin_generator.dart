import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../../annotation_readers/settings_group_reader.dart';
import '../../extensions/dart_type_x.dart';
import '../../extensions/element_x.dart';
import '../../signatures.dart';
import '../../types.dart';
import 'member_generator.dart';

@internal
class MixinGenerator {
  final ClassElement clazz;
  final SettingsGroupReader settingsGroup;

  String get mixinName => Signatures.mixin(clazz);

  const MixinGenerator({
    required this.clazz,
    required this.settingsGroup,
  });

  Mixin build() => Mixin((b) {
        b.name = mixinName;

        if (settingsGroup.root) {
          b.methods.addAll(_buildRootCommon());
        } else {
          b.methods.addAll(_buildGroupCommon());
        }

        for (final getter in clazz.abstractGetters(
          includeSuperclass: settingsGroup.includeSuperclass,
        )) {
          if (!getter.returnType
              .getAnnotation(const TypeChecker.fromRuntime(SettingsGroup))
              .isNull) {
            // skip sub groups
            continue;
          }

          MemberGenerator(getter: getter).build(b);
        }
      });

  Iterable<Method> _buildRootCommon() sync* {
    yield Method(
      (p) => p
        ..type = MethodType.getter
        ..name = Signatures.prefix
        ..returns = Types.nullableString,
    );
    yield Method(
      (p) => p
        ..name = Signatures.clear
        ..returns = Types.futureBool,
    );
    yield Method(
      (p) => p
        ..name = Signatures.reload
        ..returns = Types.futureVoid,
    );
  }

  Iterable<Method> _buildGroupCommon() sync* {
    yield Method(
      (p) => p
        ..type = MethodType.getter
        ..name = Signatures.groupKey
        ..returns = Types.string,
    );
  }
}
