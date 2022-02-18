import 'package:settings_annotation/settings_annotation.dart';
import 'package:tuple/tuple.dart';

import 'test_shared_preferences.dart';

part 'mapped_default.g.dart';

enum MappedDefaultSwitch {
  on,
  off,
}

enum MappedDefaultEnum {
  value1,
  value2,
  value3,
}

@SettingsGroup(root: true)
abstract class MappedDefault with _$MappedDefault {
  factory MappedDefault(SharedPreferences sharedPreferences, [String? prefix]) =
      _$MappedDefaultImpl;

  static Future<MappedDefault> getInstance([String? prefix]) =>
      _$MappedDefaultImpl.getInstance(prefix);

  @SettingsEntry(
      fromSettings: _switchValueFromSettings,
      toSettings: _switchValueToSettings,
      defaultValue: MappedDefaultSwitch.off)
  MappedDefaultSwitch get switchValue;
  static MappedDefaultSwitch _switchValueFromSettings(bool v) =>
      v ? MappedDefaultSwitch.on : MappedDefaultSwitch.off;
  static bool _switchValueToSettings(MappedDefaultSwitch b) =>
      b == MappedDefaultSwitch.on;

  @SettingsEntry(
    fromSettings: _mappendEnumValueFromSettings,
    toSettings: _mappendEnumValueToSettings,
    defaultValue: MappedDefaultEnum.value1,
  )
  MappedDefaultEnum get mappendEnumValue;
  static MappedDefaultEnum _mappendEnumValueFromSettings(int v) =>
      MappedDefaultEnum.values[v];
  static int _mappendEnumValueToSettings(MappedDefaultEnum e) => e.index;

  @SettingsEntry(
    fromSettings: _decimalValueFromSettings,
    toSettings: _decimalValueToSettings,
    defaultValue: Tuple2(0, 0),
  )
  Tuple2<int, int> get decimalValue;
  static Tuple2<int, int> _decimalValueFromSettings(double v) =>
      Tuple2(v.toInt(), ((v - v.toInt()) * 100).toInt());
  static double _decimalValueToSettings(Tuple2<int, int> d) =>
      d.item1 + (d.item2 / 100);

  @SettingsEntry(
    fromSettings: _uriValueFromSettings,
    toSettings: _uriValueToSettings,
    defaultValue: LiteralDefault("Uri.http('localhost', '/')"),
  )
  Uri get uriValue;
  static Uri _uriValueFromSettings(String v) => Uri.parse(v);
  static String _uriValueToSettings(Uri u) => u.toString();

  @SettingsEntry(
    fromSettings: _wordsValueFromSettings,
    toSettings: _wordsValueToSettings,
    defaultValue: '',
  )
  String get wordsValue;
  static String _wordsValueFromSettings(List<String> v) => v.join(' ');
  static List<String> _wordsValueToSettings(String w) =>
      w.isEmpty ? const [] : w.split(' ');
}
