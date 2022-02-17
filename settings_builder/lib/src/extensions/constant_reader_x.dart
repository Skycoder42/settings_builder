// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@internal
extension ConstantReaderX on ConstantReader {
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
}
