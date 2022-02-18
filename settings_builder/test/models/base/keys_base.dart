import 'package:settings_annotation/settings_annotation.dart';

abstract class KeysBase {
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
    fromSettings: fromSettings,
    toSettings: toSettings,
  )
  int? get value3;

  @SettingsEntry(
    key: 'default-mapped-value',
    fromSettings: fromSettings,
    toSettings: toSettings,
    defaultValue: 0,
  )
  int get value4;

  static int fromSettings(int s) => s ~/ 2;

  static int toSettings(int s) => s * 2;
}
