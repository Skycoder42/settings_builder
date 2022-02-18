import 'package:settings_annotation/settings_annotation.dart';
import 'package:tuple/tuple.dart';

enum MappedSwitch {
  on,
  off,
}

enum MappedEnum {
  value1,
  value2,
  value3,
}

abstract class MappedBase {
  @SettingsEntry(
    fromSettings: switchValueFromSettings,
    toSettings: switchValueToSettings,
  )
  MappedSwitch? get switchValue;
  // ignore: avoid_positional_boolean_parameters
  static MappedSwitch switchValueFromSettings(bool v) =>
      v ? MappedSwitch.on : MappedSwitch.off;
  static bool switchValueToSettings(MappedSwitch b) => b == MappedSwitch.on;

  @SettingsEntry(
    fromSettings: mappendEnumValueFromSettings,
    toSettings: mappendEnumValueToSettings,
  )
  MappedEnum? get mappendEnumValue;
  static MappedEnum mappendEnumValueFromSettings(int v) => MappedEnum.values[v];
  static int mappendEnumValueToSettings(MappedEnum e) => e.index;

  @SettingsEntry(
    fromSettings: decimalValueFromSettings,
    toSettings: decimalValueToSettings,
  )
  Tuple2<int, int>? get decimalValue;
  static Tuple2<int, int> decimalValueFromSettings(double v) =>
      Tuple2(v.toInt(), ((v - v.toInt()) * 100).toInt());
  static double decimalValueToSettings(Tuple2<int, int> d) =>
      d.item1 + (d.item2 / 100);

  @SettingsEntry(
    fromSettings: uriValueFromSettings,
    toSettings: uriValueToSettings,
  )
  Uri? get uriValue;
  static Uri uriValueFromSettings(String v) => Uri.parse(v);
  static String uriValueToSettings(Uri u) => u.toString();

  @SettingsEntry(
    fromSettings: wordsValueFromSettings,
    toSettings: wordsValueToSettings,
  )
  String? get wordsValue;
  static String wordsValueFromSettings(List<String> v) => v.join(' ');
  static List<String> wordsValueToSettings(String w) =>
      w.isEmpty ? const [] : w.split(' ');
}
