import 'package:settings_annotation/settings_annotation.dart';

import '../test_shared_preferences.dart';

part 'nested.g.dart';

@SettingsGroup()
abstract class Group1 with _$Group1 {
  int? get value1;
}

@SettingsGroup()
abstract class Group2 with _$Group2 {
  Group1 get group1;

  @SettingsEntry(defaultValue: 0)
  int get value2;
}

@SettingsGroup()
abstract class Group3 with _$Group3 {
  Group1 get group1;
  Group2 get group2;

  @SettingsEntry(
    fromSettings: _fromSettings,
    toSettings: _toSettings,
  )
  int? get value3;

  static int _fromSettings(double v) => v.toInt();
  static double _toSettings(int v) => v.toDouble();
}

@SettingsGroup(root: true)
abstract class Nested with _$Nested {
  factory Nested(SharedPreferences sharedPreferences, [String? prefix]) =
      _$NestedImpl;

  static Future<Nested> getInstance([String? prefix]) =>
      _$NestedImpl.getInstance(prefix);

  Group1 get group1;
  Group2 get group2;
  Group3 get group3;

  @SettingsEntry(
    fromSettings: _fromSettings,
    toSettings: _toSettings,
    defaultValue: 0,
  )
  int get value4;

  static int _fromSettings(double v) => v.toInt();
  static double _toSettings(int v) => v.toDouble();
}
