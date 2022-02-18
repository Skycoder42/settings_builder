import 'package:settings_annotation/settings_annotation.dart';

import 'test_shared_preferences.dart';

part 'keys.g.dart';

@SettingsGroup(root: true)
abstract class Keys with _$Keys {
  factory Keys(SharedPreferences sharedPreferences, [String? prefix]) =
      _$KeysImpl;

  static Future<Keys> getInstance([String? prefix]) =>
      _$KeysImpl.getInstance(prefix);

  @SettingsEntry(
    key: 'simple-value',
  )
  int? get value1;

  @SettingsEntry(
    key: 'default-value',
    defaultValue: 0,
  )
  int get value2;

  @SettingsEntry(
    key: 'mapped-value',
    fromSettings: _fromSettings,
    toSettings: _toSettings,
  )
  int? get value3;

  @SettingsEntry(
    key: 'default-mapped-value',
    fromSettings: _fromSettings,
    toSettings: _toSettings,
    defaultValue: 0,
  )
  int get value4;

  static int _fromSettings(int s) => s ~/ 2;
  static int _toSettings(int s) => s * 2;
}
