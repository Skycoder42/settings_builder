import 'package:settings_annotation/settings_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'simple_default.g.dart';

enum SimpleDefaultEnum {
  value1,
  value2,
  value3,
}

@SettingsGroup(root: true)
abstract class SimpleDefault with _$SimpleDefault {
  factory SimpleDefault(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SimpleDefaultImpl;

  static Future<SimpleDefault> getInstance([String? prefix]) =>
      _$SimpleDefaultImpl.getInstance(prefix);

  @SettingsEntry(defaultValue: true)
  bool get boolValue;

  @SettingsEntry(defaultValue: 1)
  int get intValue;

  @SettingsEntry(defaultValue: 0.1)
  double get doubleValue;

  @SettingsEntry(defaultValue: 2)
  num get numValue;

  @SettingsEntry(defaultValue: 'default')
  String get stringValue;

  @SettingsEntry(
    defaultValue: const ['a', 'b'],
  )
  List<String> get stringListValue;

  @SettingsEntry(defaultValue: SimpleDefaultEnum.value3)
  SimpleDefaultEnum get enumValue;
}
