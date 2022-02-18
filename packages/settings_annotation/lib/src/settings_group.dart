import 'package:meta/meta_meta.dart';

/// Declares a class as a settings group.
///
/// If this annotation exists on a class, settings code will be generated for
/// it. The annotation can only used on abstract classes. If it exists, settings
/// access will generated for every public abstract getter.
///
/// To use the generated code, you have to add the generated part and use the
/// mixin:
///
/// ```.dart
/// part 'settings.g.dart'
///
/// @SettingsGroup()
/// abstract class SettingsGroup with _$SettingsGroup {
///   int? get entry;
/// }
/// ```
///
/// This will generate a settings group. However, groups alone are not usable.
/// You need a single settings class that sets the [root] property to true to
/// serve as the settings entry point. There, you also need to define
/// constructors to create the instance:
///
/// ```.dart
/// part 'settings.g.dart'
///
/// @SettingsGroup(root: true)
/// abstract class Settings with _$Settings {
///   factory Settings(SharedPreferences sharedPreferences) = _$SettingsImpl;
///
///   // or: factory Settings(SharedPreferences sharedPreferences, [String? prefix]) = _$SettingsImpl;
///
///   // optionally, you can also reference the async factory:
///
///   Future<Settings> getInstance() => _$SettingsImpl.getInstance();
///
///   // or: Future<Settings> getInstance([String? prefix]) => _$SettingsImpl.getInstance(prefix);
///
///   int? get anotherEntry;
///
///   SettingsGroup get subGroup;
/// }
///
/// ```
@Target({TargetKind.classType})
class SettingsGroup {
  /// Specifies, whether this group is a [root] settings group.
  ///
  /// *Default value:* `false`
  ///
  /// Root groups can be constructed and serve as top level class to access
  /// settings. Non root groups can be used as children within other groups to
  /// create a hierachical structure of settings.
  final bool root;

  /// Specifies, if the generator should include abstract getters of
  /// superclasses.
  ///
  /// *Default value:* `false`
  ///
  /// By default, only abstract getters of the specific type that the
  /// annotiation was placed on are generated. However, in case you want to
  /// reuse certain definitions, you can set this to `true`. Then, the generator
  /// will recursively check superclasses to abstract getters to also implement.
  final bool includeSuperclass;

  /// Default constructor.
  const SettingsGroup({
    this.root = false,
    this.includeSuperclass = false,
  });
}
