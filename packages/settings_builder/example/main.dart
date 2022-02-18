// ignore_for_file: prefer_constructors_over_static_methods, avoid_print

import 'package:settings_annotation/settings_annotation.dart';

import 'shared_preferences.dart';

part 'main.g.dart';

class Color {
  final int argb;

  const Color(this.argb);

  static Color fromValue(int v) => Color(v);
  static int toValue(Color c) => c.argb;
}

enum LogLevel {
  debug,
  info,
  warn,
  error,
}

@SettingsGroup()
abstract class AccountSettings with _$AccountSettings {
  // stored under as custom key, uses false as default value if not set
  @SettingsEntry(
    key: 'logged-in',
    defaultValue: false,
  )
  bool get loggedIn;

  // returns null if consent has not been set yet
  bool? get consent;

  // returns null if name has not been set yet
  String? get name;
}

@SettingsGroup(root: true)
abstract class Settings with _$Settings {
  factory Settings(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SettingsImpl;

  static Future<Settings> getInstance([String? prefix]) =>
      _$SettingsImpl.getInstance();

  AccountSettings get account;

  @SettingsEntry(
    fromSettings: Color.fromValue,
    toSettings: Color.toValue,
  )
  Color? get color;

  @SettingsEntry(
    key: 'log-level',
    defaultValue: LogLevel.warn,
  )
  LogLevel get logLevel;

  @SettingsEntry(
    fromSettings: _uriFromSettings,
    toSettings: _uriToSettings,
    defaultValue: LiteralDefault("Uri.http('localhost', '/')"),
  )
  Uri get api;

  static Uri _uriFromSettings(String value) => Uri.parse(value);
  static String _uriToSettings(Uri uri) => uri.toString();
}

Future<void> main() async {
  // create a settings instance with 'app' prefix
  final settings = await Settings.getInstance('app');

  // default values
  print('${settings.account.loggedInKey}: ${settings.account.loggedIn}');
  print('${settings.account.consentKey}: ${settings.account.consent}');
  print('${settings.account.nameKey}: ${settings.account.name}');
  print('${settings.colorKey}: ${settings.color}');
  print('${settings.logLevelKey}: ${settings.logLevel}');
  print('${settings.apiKey}: ${settings.api}');

  // check for consent, then update if
  if (!settings.account.hasConsent) {
    print('Requesting consent...');
    await Future<void>.delayed(const Duration(seconds: 1));
    print('Granted!');
    await settings.account.setConsent(true);
    print('${settings.account.consentKey}: ${settings.account.consent}');
  }

  // update the API url
  await settings.setApi(Uri.https('example.com', '/api'));
  print('${settings.apiKey}: ${settings.api}');

  // remove API url again
  await settings.removeApi();
  print('${settings.apiKey}: ${settings.api}');
}
