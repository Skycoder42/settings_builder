// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_helper/source_helper.dart';

import '../../extensions/dart_type_x.dart';
import '../writer.dart';

@internal
class MemberWriter implements Writer {
  final PropertyAccessorElement getter;

  const MemberWriter({
    required this.getter,
  });

  @override
  void call(StringBuffer buffer) {
    final setterType = getter.returnType.baseTypeName;

    buffer
      ..writeln('String get ${getter.name}Key;')
      ..writeln()
      ..writeln('bool get has${getter.name.pascal};')
      ..writeln()
      ..writeln('Future<bool> set${getter.name.pascal}($setterType value);')
      ..writeln()
      ..writeln('Future<bool> remove${getter.name.pascal}();')
      ..writeln();
  }
}
