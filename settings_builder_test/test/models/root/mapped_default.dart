import 'package:settings_annotation/settings_annotation.dart';
import 'package:tuple/tuple.dart';

import '../base/mapped_default_base.dart';
import '../test_shared_preferences.dart';

part 'mapped_default.g.dart';

@SettingsGroup(root: true, includeSuperclass: true)
abstract class MappedDefault extends MappedDefaultBase with _$MappedDefault {
  factory MappedDefault(SharedPreferences sharedPreferences, [String? prefix]) =
      _$MappedDefaultImpl;

  static Future<MappedDefault> getInstance([String? prefix]) =>
      _$MappedDefaultImpl.getInstance(prefix);
}
