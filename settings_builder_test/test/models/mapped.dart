import 'package:settings_annotation/settings_annotation.dart';
import 'package:tuple/tuple.dart';

import 'test_shared_preferences.dart';

part 'mapped.g.dart';

enum MappedSwitch {
  on,
  off,
}

enum MappedEnum {
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

  @SettingsEntry(
    fromSettings: _switchValueFromSettings,
    toSettings: _switchValueToSettings,
  )
  MappedSwitch? get switchValue;
  static MappedSwitch _switchValueFromSettings(bool v) =>
      v ? MappedSwitch.on : MappedSwitch.off;
  static bool _switchValueToSettings(MappedSwitch b) => b == MappedSwitch.on;

  @SettingsEntry(
    fromSettings: _mappendEnumValueFromSettings,
    toSettings: _mappendEnumValueToSettings,
  )
  MappedEnum? get mappendEnumValue;
  static MappedEnum _mappendEnumValueFromSettings(int v) =>
      MappedEnum.values[v];
  static int _mappendEnumValueToSettings(MappedEnum e) => e.index;

  @SettingsEntry(
    fromSettings: _decimalValueFromSettings,
    toSettings: _decimalValueToSettings,
  )
  Tuple2<int, int>? get decimalValue;
  static Tuple2<int, int> _decimalValueFromSettings(double v) =>
      Tuple2(v.toInt(), ((v - v.toInt()) * 100).toInt());
  static double _decimalValueToSettings(Tuple2<int, int> d) =>
      d.item1 + (d.item2 / 100);

  @SettingsEntry(
    fromSettings: _uriValueFromSettings,
    toSettings: _uriValueToSettings,
  )
  Uri? get uriValue;
  static Uri _uriValueFromSettings(String v) => Uri.parse(v);
  static String _uriValueToSettings(Uri u) => u.toString();

  @SettingsEntry(
    fromSettings: _wordsValueFromSettings,
    toSettings: _wordsValueToSettings,
  )
  String? get wordsValue;
  static String _wordsValueFromSettings(List<String> v) => v.join(' ');
  static List<String> _wordsValueToSettings(String w) =>
      w.isEmpty ? const [] : w.split(' ');
}
