import 'package:settings_annotation/settings_annotation.dart';

enum SimpleDefaultEnum {
  value1,
  value2,
  value3,
}

abstract class SimpleDefaultBase {
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
