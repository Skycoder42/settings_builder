import 'package:settings_annotation/settings_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mapped.g.dart';

enum SimpleEnum {
  value1,
  value2,
  value3,
}

@SettingsGroup(root: true)
abstract class Mapped with _$Mapped {
  factory Mapped(SharedPreferences sharedPreferences, [String? prefix]) =
      _$MappedImpl;

  static Future<Mapped> getInstance([String? prefix]) =>
      _$MappedImpl.getInstance(prefix);

  bool? get boolValue;

  int? get intValue;

  double? get doubleValue;

  num? get numValue;

  String? get stringValue;

  List<String>? get stringListValue;

  SimpleEnum? get enumValue;
}
