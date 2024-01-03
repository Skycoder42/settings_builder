import 'package:analyzer/dart/element/type.dart' as ast_type;
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:source_helper/source_helper.dart';

@internal
abstract base class Types {
  Types._();

  static Reference fromDartType(
    ast_type.DartType dartType, {
    bool? isNull,
  }) {
    if (dartType is ast_type.VoidType || dartType.isDartCoreNull) {
      return void$;
    } else if (dartType is ast_type.RecordType) {
      return _fromRecord(dartType, isNull);
    } else {
      return TypeReference(
        (b) {
          b
            ..symbol = dartType.element!.name
            ..isNullable = isNull ?? dartType.isNullableType;

          if (dartType is ast_type.InterfaceType) {
            b.types.addAll(dartType.typeArguments.map(fromDartType));
          }
        },
      );
    }
  }

  static final void$ = TypeReference(
    (b) => b..symbol = 'void',
  );

  static final string = TypeReference(
    (b) => b..symbol = 'String',
  );

  static final nullableString = TypeReference(
    (b) => b
      ..symbol = 'String'
      ..isNullable = true,
  );

  static final boolean = TypeReference(
    (b) => b..symbol = 'bool',
  );

  static TypeReference future(TypeReference type) => TypeReference(
        (b) => b
          ..symbol = 'Future'
          ..types.add(type),
      );

  static final futureBool = future(boolean);

  static final futureVoid = future(void$);

  static final sharedPreferences = TypeReference(
    (b) => b..symbol = 'SharedPreferences',
  );

  static RecordType _fromRecord(
    ast_type.RecordType record,
    bool? isNull,
  ) =>
      RecordType(
        (b) => b
          ..isNullable = isNull ?? record.isNullableType
          ..positionalFieldTypes.addAll([
            for (final field in record.positionalFields)
              fromDartType(field.type),
          ])
          ..namedFieldTypes.addAll({
            for (final field in record.namedFields)
              field.name: fromDartType(field.type),
          }),
      );
}
