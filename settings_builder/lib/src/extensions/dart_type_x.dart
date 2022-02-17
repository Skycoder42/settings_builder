// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import './element_x.dart';

@internal
extension DartTypeX on DartType {
  String get baseTypeName => getDisplayString(withNullability: false);

  ConstantReader getAnnotation<T>() =>
      element?.getAnnotation<T>() ?? ConstantReader(null);
}
