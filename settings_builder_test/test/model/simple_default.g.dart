// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_default.dart';

// **************************************************************************
// SettingsGenerator
// **************************************************************************

// ignore_for_file: avoid_positional_boolean_parameters

mixin _$SimpleDefault {
  String? get prefix;

  Future<bool> clear();

  String get boolValueKey;

  bool get hasBoolValue;

  Future<bool> setBoolValue(bool value);

  Future<bool> removeBoolValue();

  String get intValueKey;

  bool get hasIntValue;

  Future<bool> setIntValue(int value);

  Future<bool> removeIntValue();

  String get doubleValueKey;

  bool get hasDoubleValue;

  Future<bool> setDoubleValue(double value);

  Future<bool> removeDoubleValue();

  String get numValueKey;

  bool get hasNumValue;

  Future<bool> setNumValue(num value);

  Future<bool> removeNumValue();

  String get stringValueKey;

  bool get hasStringValue;

  Future<bool> setStringValue(String value);

  Future<bool> removeStringValue();

  String get stringListValueKey;

  bool get hasStringListValue;

  Future<bool> setStringListValue(List<String> value);

  Future<bool> removeStringListValue();

  String get enumValueKey;

  bool get hasEnumValue;

  Future<bool> setEnumValue(SimpleDefaultEnum value);

  Future<bool> removeEnumValue();
} // _$SimpleDefault

class _$SimpleDefaultImpl implements SimpleDefault {
  final SharedPreferences _sharedPreferences;

  @override
  final String? prefix;

  _$SimpleDefaultImpl(this._sharedPreferences, [this.prefix]);

  static Future<SimpleDefault> getInstance([String? prefix]) async =>
      _$SimpleDefaultImpl(await SharedPreferences.getInstance(), prefix);

  @override
  Future<bool> clear() => _sharedPreferences.clear();

  @override
  late final boolValueKey = prefix != null ? '$prefix.boolValue' : 'boolValue';

  @override
  bool get hasBoolValue => _sharedPreferences.containsKey(boolValueKey);

  @override
  bool get boolValue => _sharedPreferences.getBool(boolValueKey) ?? true;

  @override
  Future<bool> setBoolValue(bool $value) =>
      _sharedPreferences.setBool(boolValueKey, $value);

  @override
  Future<bool> removeBoolValue() => _sharedPreferences.remove(boolValueKey);

  @override
  late final intValueKey = prefix != null ? '$prefix.intValue' : 'intValue';

  @override
  bool get hasIntValue => _sharedPreferences.containsKey(intValueKey);

  @override
  int get intValue => _sharedPreferences.getInt(intValueKey) ?? 1;

  @override
  Future<bool> setIntValue(int $value) =>
      _sharedPreferences.setInt(intValueKey, $value);

  @override
  Future<bool> removeIntValue() => _sharedPreferences.remove(intValueKey);

  @override
  late final doubleValueKey =
      prefix != null ? '$prefix.doubleValue' : 'doubleValue';

  @override
  bool get hasDoubleValue => _sharedPreferences.containsKey(doubleValueKey);

  @override
  double get doubleValue => _sharedPreferences.getDouble(doubleValueKey) ?? 0.1;

  @override
  Future<bool> setDoubleValue(double $value) =>
      _sharedPreferences.setDouble(doubleValueKey, $value);

  @override
  Future<bool> removeDoubleValue() => _sharedPreferences.remove(doubleValueKey);

  @override
  late final numValueKey = prefix != null ? '$prefix.numValue' : 'numValue';

  @override
  bool get hasNumValue => _sharedPreferences.containsKey(numValueKey);

  @override
  num get numValue => _sharedPreferences.getDouble(numValueKey) ?? 2;

  @override
  Future<bool> setNumValue(num $value) =>
      _sharedPreferences.setDouble(numValueKey, $value.toDouble());

  @override
  Future<bool> removeNumValue() => _sharedPreferences.remove(numValueKey);

  @override
  late final stringValueKey =
      prefix != null ? '$prefix.stringValue' : 'stringValue';

  @override
  bool get hasStringValue => _sharedPreferences.containsKey(stringValueKey);

  @override
  String get stringValue =>
      _sharedPreferences.getString(stringValueKey) ?? 'default';

  @override
  Future<bool> setStringValue(String $value) =>
      _sharedPreferences.setString(stringValueKey, $value);

  @override
  Future<bool> removeStringValue() => _sharedPreferences.remove(stringValueKey);

  @override
  late final stringListValueKey =
      prefix != null ? '$prefix.stringListValue' : 'stringListValue';

  @override
  bool get hasStringListValue =>
      _sharedPreferences.containsKey(stringListValueKey);

  @override
  List<String> get stringListValue =>
      _sharedPreferences.getStringList(stringListValueKey) ?? const ['a', 'b'];

  @override
  Future<bool> setStringListValue(List<String> $value) =>
      _sharedPreferences.setStringList(stringListValueKey, $value);

  @override
  Future<bool> removeStringListValue() =>
      _sharedPreferences.remove(stringListValueKey);

  @override
  late final enumValueKey = prefix != null ? '$prefix.enumValue' : 'enumValue';

  @override
  bool get hasEnumValue => _sharedPreferences.containsKey(enumValueKey);

  @override
  SimpleDefaultEnum get enumValue {
    final $value = _sharedPreferences.getString(enumValueKey);
    return $value != null
        ? SimpleDefaultEnum.values.byName($value)
        : SimpleDefaultEnum.value3;
  }

  @override
  Future<bool> setEnumValue(SimpleDefaultEnum $value) =>
      _sharedPreferences.setString(enumValueKey, $value.name);

  @override
  Future<bool> removeEnumValue() => _sharedPreferences.remove(enumValueKey);
} // _$SimpleDefaultImpl
