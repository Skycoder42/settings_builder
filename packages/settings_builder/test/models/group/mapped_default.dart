import 'package:settings_annotation/settings_annotation.dart';

import '../base/mapped_default_base.dart';
import '../test_shared_preferences.dart';

part 'mapped_default.g.dart';

@SettingsGroup(includeSuperclass: true)
abstract class MappedDefaultGroup extends MappedDefaultBase
    with _$MappedDefaultGroup {}

@SettingsGroup(root: true)
abstract class MappedDefault with _$MappedDefault {
  factory MappedDefault(SharedPreferences sharedPreferences, [String? prefix]) =
      _$MappedDefaultImpl;

  static Future<MappedDefault> getInstance([String? prefix]) =>
      _$MappedDefaultImpl.getInstance(prefix);

  MappedDefaultGroup get mapped;
}
