import 'package:settings_annotation/settings_annotation.dart';

import '../base/keys_base.dart';
import '../test_shared_preferences.dart';

part 'keys.g.dart';

@SettingsGroup(includeSuperclass: true)
abstract class KeysGroup extends KeysBase with _$KeysGroup {}

@SettingsGroup(root: true)
abstract class Keys with _$Keys {
  factory Keys(SharedPreferences sharedPreferences, [String? prefix]) =
      _$KeysImpl;

  static Future<Keys> getInstance([String? prefix]) =>
      _$KeysImpl.getInstance(prefix);

  KeysGroup get keys;
}
