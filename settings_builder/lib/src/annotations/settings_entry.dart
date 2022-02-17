import 'package:meta/meta_meta.dart';

@Target({TargetKind.getter})
class SettingsEntry {
  final String? key;
  final dynamic defaultValue;
  final Function? toSettings;
  final Function? fromSettings;

  const SettingsEntry({
    this.key,
    this.defaultValue,
    this.toSettings,
    this.fromSettings,
  });
}
