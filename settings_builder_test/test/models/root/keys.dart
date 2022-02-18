import 'package:settings_annotation/settings_annotation.dart';

import '../base/keys_base.dart';
import '../test_shared_preferences.dart';

part 'keys.g.dart';

@SettingsGroup(root: true, includeSuperclass: true)
abstract class Keys extends KeysBase with _$Keys {
  factory Keys(SharedPreferences sharedPreferences, [String? prefix]) =
      _$KeysImpl;

  static Future<Keys> getInstance([String? prefix]) =>
      _$KeysImpl.getInstance(prefix);
}
