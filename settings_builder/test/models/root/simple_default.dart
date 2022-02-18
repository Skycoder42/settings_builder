import 'package:settings_annotation/settings_annotation.dart';

import '../base/simple_default.dart';
import '../test_shared_preferences.dart';

part 'simple_default.g.dart';

@SettingsGroup(root: true, includeSuperclass: true)
abstract class SimpleDefault extends SimpleDefaultBase with _$SimpleDefault {
  factory SimpleDefault(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SimpleDefaultImpl;

  static Future<SimpleDefault> getInstance([String? prefix]) =>
      _$SimpleDefaultImpl.getInstance(prefix);
}
