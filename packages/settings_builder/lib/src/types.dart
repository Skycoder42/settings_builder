// ignore_for_file: public_member_api_docs

import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

@internal
abstract class Types {
  Types._();

  static late final void$ = TypeReference(
    (b) => b..symbol = 'void',
  );

  static late final string = TypeReference(
    (b) => b..symbol = 'String',
  );

  static late final nullableString = TypeReference(
    (b) => b
      ..replace(string)
      ..isNullable = true,
  );

  static late final boolean = TypeReference(
    (b) => b..symbol = 'bool',
  );

  static TypeReference future(TypeReference type) => TypeReference(
        (b) => b
          ..symbol = 'Future'
          ..types.add(type),
      );

  static late final futureBool = future(boolean);

  static late final futureVoid = future(void$);

  static late final sharedPreferences = TypeReference(
    (b) => b..symbol = 'SharedPreferences',
  );
}
