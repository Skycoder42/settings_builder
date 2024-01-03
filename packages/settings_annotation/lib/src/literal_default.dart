import 'settings_entry.dart';

/// A helper class to construct default values that are not const
///
/// This value can be used with [SettingsEntry.defaultValue] to provide a value
/// that is not const constructible. For example, if you want to use as [Uri] as
/// default value, you could do the following:
///
/// ```.dart
/// @SettingsEntry(
///   defaultValue: LiteralDefault('Uri()'),
/// )
/// Uri? get value;
/// ```
class LiteralDefault {
  /// The literal value to be used as default.
  final String literalValue;

  /// Default constructor.
  const LiteralDefault(this.literalValue);
}
