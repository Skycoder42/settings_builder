// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';

@internal
extension DartTypeX on DartType {
  String get baseTypeName => getDisplayString(withNullability: false);

  bool hasAnnotation<T>() =>
      element?.metadata
          .map((annotation) => annotation.element)
          .whereType<ConstructorElement>()
          .map((e) => e.enclosingElement)
          .any((c) => c.name == T.toString()) ??
      false;
}
