import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class SettingsGroup {
  final bool root;
  final bool includeSuperclass;

  const SettingsGroup({
    this.root = false,
    this.includeSuperclass = false,
  });
}
