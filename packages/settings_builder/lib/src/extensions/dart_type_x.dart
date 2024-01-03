import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import './element_x.dart';

@internal
extension DartTypeX on DartType {
  ConstantReader getAnnotation(TypeChecker typeChecker) =>
      element?.getAnnotation(typeChecker) ?? ConstantReader(null);
}
