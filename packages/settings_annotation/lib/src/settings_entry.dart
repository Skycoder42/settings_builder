import 'package:meta/meta_meta.dart';

/// Allow you to defined additional properties on an abstract getter of a
/// [SettingsGroup].
///
/// This annotation is not required, as all abstract getters of a class
/// annotated with [SettingsGroup] will get generated implementations. However,
/// sometimes you need to tweak the generated code. That is where this
/// annotation comes into play.
@Target({TargetKind.getter})
class SettingsEntry {
  /// A custom key to be used as the key for the shared preferences.
  ///
  /// If not set, the name of the annotated getter is used.
  final String? key;

  /// A custom default value.
  ///
  /// This value is returned in case the requested setting is not stored in the
  /// shared preferences.
  ///
  /// Can be any constant value, but must match the return type of the getter.
  /// If a non null defaultValue is set, then the getter can return a non
  /// nullable value as well.
  ///
  /// If the default value is a non constant value, you cannot simply set the
  /// value here. Instead, pass as [LiteralDefault] value with the code to
  /// construct the value as string.
  ///
  /// If not set, `null` is returned as default value.
  final dynamic defaultValue;

  /// A custom converter to transform a value of the getters return type to a
  /// settings compatible value.
  ///
  /// Must always have the signature `TSettings Function(TValue)`. Additional
  /// optional parameters are allowed, but will not be used by the generated
  /// settings. `TSettings` must be a settings compatible type. Those are listed
  /// below. `TValue` must be the same type as the return type of the gettern,
  /// but should non nullable even if the return type is nullable. In addition,
  /// the function must either be a top level function or a static member
  /// function.
  ///
  /// Allowed types for `TSettings`:
  /// - [bool]
  /// - [int]
  /// - [double]
  /// - [num]
  /// - [String]
  /// - [List]<String>
  /// - a dart [enum]
  final Function? toSettings;

  /// A custom converter to transform a settings compatible value to a value
  /// of the getters return type.
  ///
  /// Must always have the signature `TValue Function(TSettings)`. Additional
  /// optional parameters are allowed, but will not be used by the generated
  /// settings. `TSettings` must be a settings compatible type. Those are listed
  /// below. `TValue` must be the same type as the return type of the gettern,
  /// but should non nullable even if the return type is nullable. In addition,
  /// the function must either be a top level function or a static member
  /// function. It will only be called if a valid value is read from the
  /// settings.
  ///
  /// Allowed types for `TSettings`:
  /// - [bool]
  /// - [int]
  /// - [double]
  /// - [num]
  /// - [String]
  /// - [List]<String>
  /// - a dart [enum]
  final Function? fromSettings;

  /// Default constructor.
  const SettingsEntry({
    this.key,
    this.defaultValue,
    this.toSettings,
    this.fromSettings,
  });
}
