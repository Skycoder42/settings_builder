import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@internal
extension ConstantReaderX on ConstantReader {
  static final _expando = Expando<ElementAnnotation>();

  ElementAnnotation? get annotation => _expando[this];

  set annotation(ElementAnnotation? element) => _expando[this] = element;

  ConstantReader maybeRead(String name) =>
      isNull ? ConstantReader(null) : read(name);

  String? maybeReadString(String name) {
    final field = maybeRead(name);
    return field.isString ? field.stringValue : null;
  }

  ExecutableElement? maybeReadFn(String name) {
    final field = maybeRead(name);
    return field.isNull ? null : field.objectValue.toFunctionValue();
  }

  String? toSource() => annotation?.toSource();
}
