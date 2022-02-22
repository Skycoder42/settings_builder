// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

import '../../extensions/dart_type_x.dart';
import '../../signatures.dart';
import '../../types.dart';

@internal
class MemberGenerator {
  final PropertyAccessorElement getter;

  const MemberGenerator({
    required this.getter,
  });

  void build(MixinBuilder b) {
    b.methods.addAll([
      Method(
        (b) => b
          ..type = MethodType.getter
          ..name = Signatures.entryKey(getter)
          ..returns = Types.string,
      ),
      Method(
        (b) => b
          ..type = MethodType.getter
          ..name = Signatures.hasEntry(getter)
          ..returns = Types.boolean,
      ),
      Method(
        (b) => b
          ..name = Signatures.setEntry(getter)
          ..requiredParameters.add(
            Parameter(
              (b) => b
                ..name = 'value'
                ..type = TypeReference(
                  (b) => b
                    ..replace(getter.returnType.typeReference)
                    ..isNullable = false,
                ),
            ),
          )
          ..returns = Types.futureBool,
      ),
      Method(
        (b) => b
          ..name = Signatures.removeEntry(getter)
          ..returns = Types.futureBool,
      )
    ]);
  }
}
