import 'package:settings_annotation/settings_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'simple.g.dart';

enum SimpleEnum {
  value1,
  value2,
  value3,
}

@SettingsGroup(root: true)
abstract class Simple with _$Simple {
  factory Simple(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SimpleImpl;

  static Future<Simple> getInstance([String? prefix]) =>
      _$SimpleImpl.getInstance(prefix);

  bool? get boolValue;

  int? get intValue;

  double? get doubleValue;

  num? get numValue;

  String? get stringValue;

  List<String>? get stringListValue;

  SimpleEnum? get enumValue;
}
