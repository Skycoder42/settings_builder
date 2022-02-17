// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'constant_reader_x.dart';

@internal
extension ElementX on Element {
  ConstantReader getAnnotation(TypeChecker typeChecker) => metadata
      .map(
        (annotation) {
          final computedValue = annotation.computeConstantValue();
          if (computedValue == null &&
              (annotation.constantEvaluationErrors?.isNotEmpty ?? false)) {
            throw InvalidGenerationSourceError(
              annotation.constantEvaluationErrors!.toString(),
              element: annotation.element,
            );
          }

          return ConstantReader(computedValue)..annotation = annotation;
        },
      )
      .where(
        (reader) =>
            !reader.isNull &&
            reader.objectValue.type != null &&
            typeChecker.isExactlyType(reader.objectValue.type!),
      )
      .firstWhere(
        (reader) => !reader.isNull,
        orElse: () => ConstantReader(null),
      );
}

@internal
extension ClassElementX on ClassElement {
  Iterable<PropertyAccessorElement> get abstractGetters =>
      accessors.where((accessor) => accessor.isGetter && accessor.isAbstract);
}
