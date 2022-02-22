// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:source_helper/source_helper.dart';

@internal
abstract class Signatures {
  Signatures._();

  static const groupKey = 'key';
  static const prefix = 'prefix';
  static const prefixRef = Reference(prefix);
  static const sharedPreferences = 'sharedPreferences';
  static const sharedPreferencesRef = Reference(sharedPreferences);

  static const getInstance = 'getInstance';
  static const clear = 'clear';
  static const reload = 'reload';

  static String mixin(Element type) => '_\$${type.name}';
  static String impl(Element type) => '_\$${type.name}Impl';

  static String entryKey(PropertyAccessorElement getter) => '${getter.name}Key';
  static Reference entryKeyRef(PropertyAccessorElement getter) =>
      Reference(entryKey(getter));
  static String hasEntry(PropertyAccessorElement getter) =>
      'has${getter.name.pascal}';
  static String getEntry(PropertyAccessorElement getter) => getter.name;
  static String setEntry(PropertyAccessorElement getter) =>
      'set${getter.name.pascal}';
  static String removeEntry(PropertyAccessorElement getter) =>
      'remove${getter.name.pascal}';
}
