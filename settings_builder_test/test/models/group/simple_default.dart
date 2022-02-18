import 'package:settings_annotation/settings_annotation.dart';

import '../base/simple_default.dart';
import '../test_shared_preferences.dart';

part 'simple_default.g.dart';

@SettingsGroup(includeSuperclass: true)
abstract class SimpleDefaultGroup extends SimpleDefaultBase
    with _$SimpleDefaultGroup {}

@SettingsGroup(root: true)
abstract class SimpleDefault with _$SimpleDefault {
  factory SimpleDefault(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SimpleDefaultImpl;

  static Future<SimpleDefault> getInstance([String? prefix]) =>
      _$SimpleDefaultImpl.getInstance(prefix);

  SimpleDefaultGroup get simple;
}
