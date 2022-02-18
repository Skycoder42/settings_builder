import 'package:settings_annotation/settings_annotation.dart';
import 'package:tuple/tuple.dart';

enum MappedDefaultSwitch {
  on,
  off,
}

enum MappedDefaultEnum {
  value1,
  value2,
  value3,
}

abstract class MappedDefaultBase {
  @SettingsEntry(
    fromSettings: switchValueFromSettings,
    toSettings: switchValueToSettings,
    defaultValue: MappedDefaultSwitch.off,
  )
  MappedDefaultSwitch get switchValue;
  // ignore: avoid_positional_boolean_parameters
  static MappedDefaultSwitch switchValueFromSettings(bool v) =>
      v ? MappedDefaultSwitch.on : MappedDefaultSwitch.off;
  static bool switchValueToSettings(MappedDefaultSwitch b) =>
      b == MappedDefaultSwitch.on;

  @SettingsEntry(
    fromSettings: mappendEnumValueFromSettings,
    toSettings: mappendEnumValueToSettings,
    defaultValue: MappedDefaultEnum.value1,
  )
  MappedDefaultEnum get mappendEnumValue;
  static MappedDefaultEnum mappendEnumValueFromSettings(int v) =>
      MappedDefaultEnum.values[v];
  static int mappendEnumValueToSettings(MappedDefaultEnum e) => e.index;

  @SettingsEntry(
    fromSettings: decimalValueFromSettings,
    toSettings: decimalValueToSettings,
    defaultValue: Tuple2(0, 0),
  )
  Tuple2<int, int> get decimalValue;
  static Tuple2<int, int> decimalValueFromSettings(double v) =>
      Tuple2(v.toInt(), ((v - v.toInt()) * 100).toInt());
  static double decimalValueToSettings(Tuple2<int, int> d) =>
      d.item1 + (d.item2 / 100);

  @SettingsEntry(
    fromSettings: uriValueFromSettings,
    toSettings: uriValueToSettings,
    defaultValue: LiteralDefault("Uri.http('localhost', '/')"),
  )
  Uri get uriValue;
  static Uri uriValueFromSettings(String v) => Uri.parse(v);
  static String uriValueToSettings(Uri u) => u.toString();

  @SettingsEntry(
    fromSettings: wordsValueFromSettings,
    toSettings: wordsValueToSettings,
    defaultValue: '',
  )
  String get wordsValue;
  static String wordsValueFromSettings(List<String> v) => v.join(' ');
  static List<String> wordsValueToSettings(String w) =>
      w.isEmpty ? const [] : w.split(' ');
}
