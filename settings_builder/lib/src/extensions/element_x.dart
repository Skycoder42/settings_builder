// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@internal
extension ElementX on Element {
  ConstantReader getAnnotation<T>() => metadata.where((annotation) {
        final element = annotation.element;
        if (element is! ConstructorElement) {
          return false;
        }
        final classElement = element.enclosingElement;
        return classElement.name == T.toString();
      }).map((a) {
        final computedValue = a.computeConstantValue();
        if (computedValue == null &&
            (a.constantEvaluationErrors?.isNotEmpty ?? false)) {
          throw InvalidGenerationSourceError(
            a.constantEvaluationErrors!.toString(),
            element: a.element,
          );
        }
        return ConstantReader(computedValue);
      }).firstWhere(
        (reader) => !reader.isNull,
        orElse: () => ConstantReader(null),
      );
}

@internal
extension ClassElementX on ClassElement {
  Iterable<PropertyAccessorElement> get abstractGetters =>
      accessors.where((accessor) => accessor.isGetter && accessor.isAbstract);
}
