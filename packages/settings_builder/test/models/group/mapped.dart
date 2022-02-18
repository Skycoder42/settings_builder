import 'package:settings_annotation/settings_annotation.dart';
import 'package:tuple/tuple.dart';

import '../base/mapped_base.dart';
import '../test_shared_preferences.dart';

part 'mapped.g.dart';

@SettingsGroup(includeSuperclass: true)
abstract class MappedGroup extends MappedBase with _$MappedGroup {}

@SettingsGroup(root: true)
abstract class Mapped with _$Mapped {
  factory Mapped(SharedPreferences sharedPreferences, [String? prefix]) =
      _$MappedImpl;

  static Future<Mapped> getInstance([String? prefix]) =>
      _$MappedImpl.getInstance(prefix);

  MappedGroup get mapped;
}
