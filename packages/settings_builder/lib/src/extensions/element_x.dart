import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
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
extension InterfaceTypeX on InterfaceType {
  Iterable<PropertyAccessorElement> get abstractGetters =>
      (superclass?.abstractGetters ?? const []).followedBy(
        accessors.where((accessor) => accessor.isGetter && accessor.isAbstract),
      );
}

@internal
extension TypeDefiningElementX on TypeDefiningElement {
  TypeReference get typeReference => TypeReference((b) => b.symbol = name);
}

@internal
extension ClassElementX on ClassElement {
  Iterable<PropertyAccessorElement> abstractGetters({
    required bool includeSuperclass,
  }) {
    final superclass = includeSuperclass ? supertype : null;
    return (superclass?.abstractGetters ?? const []).followedBy(
      accessors.where((accessor) => accessor.isGetter && accessor.isAbstract),
    );
  }
}

@internal
extension ExecutableElementX on ExecutableElement {
  Expression get funcExpr {
    final self = this;
    if (self is MethodElement) {
      return Reference(self.enclosingElement.name).property(name);
    } else {
      return Reference(name);
    }
  }
}
