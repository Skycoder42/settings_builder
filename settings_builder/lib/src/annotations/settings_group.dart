import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class SettingsGroup {
  final bool root;

  const SettingsGroup({
    this.root = false,
  });
}
