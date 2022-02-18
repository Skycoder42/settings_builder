import 'package:settings_annotation/settings_annotation.dart';

import '../base/simple.dart';
import '../test_shared_preferences.dart';

part 'simple.g.dart';

@SettingsGroup(root: true, includeSuperclass: true)
abstract class Simple extends SimpleBase with _$Simple {
  factory Simple(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SimpleImpl;

  static Future<Simple> getInstance([String? prefix]) =>
      _$SimpleImpl.getInstance(prefix);
}
