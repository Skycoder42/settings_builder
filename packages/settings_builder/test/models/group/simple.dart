import 'package:settings_annotation/settings_annotation.dart';

import '../base/simple.dart';
import '../test_shared_preferences.dart';

part 'simple.g.dart';

@SettingsGroup(includeSuperclass: true)
abstract class SimpleGroup extends SimpleBase with _$SimpleGroup {}

@SettingsGroup(root: true)
abstract class Simple with _$Simple {
  factory Simple(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SimpleImpl;

  static Future<Simple> getInstance([String? prefix]) =>
      _$SimpleImpl.getInstance(prefix);

  SimpleGroup get simple;
}
