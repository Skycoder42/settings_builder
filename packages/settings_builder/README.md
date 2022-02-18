# settings_builder
[![CI/CD for settings_builder](https://github.com/Skycoder42/settings_builder/actions/workflows/settings_builder.yml/badge.svg)](https://github.com/Skycoder42/settings_builder/actions/workflows/settings_builder.yml)
[![Pub Version](https://img.shields.io/pub/v/settings_builder)](https://pub.dev/packages/settings_builder)

A dart builder that generates automatic accessors for reading and writing shared preferences.

## Table of contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Features
- Generates compile time safe access to `SharedPreferences`.
- Assumes a native API like [shared_preferences](https://pub.dev/packages/shared_preferences)
  - Does not depend on that package, which means you can implement your own if whished.
  - Works with non flutter projects
- Built-In support for all types compatible with `SharedPreferences`
  - Allow definition of default values
  - Supports any type via custom converters.
- Hierachical structuring

## Installation
As this is a builder package, you need to also install the annotations and build_runner:

```pubspec.yaml
dependencies:
  settings_annotation: <latest>

dev_dependencies:
  build_runner: <latest>
  settings_builder: <latest>
```

## Usage
The following is a very basic example to get started. For a more feature complete example, check out the Example page.

Generating the settings does not required much setup. The following is a very basic example to get things running. It
provides a simple settings instance with two entries: a `logLevel`, stored as an int, and an `account`. The account
itself is a subgroup that contains a `loggedIn` boolean which defaults to `false` and a `name`.

```.dart
part 'settings.g.dart'; // assume this file is named 'settings.dart'

@SettingsGroup()
abstract class AccountSettings with _$AccountSettings {
  @SettingsEntry(defaultValue: false)
  bool get loggedIn;

  String? get name;
}

@SettingsGroup(root: true)
abstract class Settings with _$Settings {
  factory Settings(SharedPreferences sharedPreferences, [String? prefix]) =
      _$SettingsImpl;

  static Future<Settings> getInstance([String? prefix]) =>
      _$SettingsImpl.getInstance();

  AccountSettings get account;

  int? get logLevel;
}
```

Now run `dart run build_runner build` and the code will get generated.

To use these generated settings, you can simply create a new instance via `getInstance` and then use the getters and
the other generated members:

```.dart
final settings = await Settings.getInstance();

// the keys under which settings are stored are auto generated:
print(settings.account.loggedInKey); // prints 'account.loggedIn'
print(settings.logLevelKey); // prints 'logLevel'

// initially, values are not set:
print(settings.account.hasLoggedIn); // prints false
print(settings.account.loggedIn); // prints false
print(settings.hasLogLevel); // prints false
print(settings.logLevel); // prints null

// you can update them:
await settings.setLogLevel(10);
print(settings.hasLogLevel); // prints true
print(settings.logLevel); // prints 10

// and you can remove them again
await settings.removeLogLevel();
print(settings.hasLogLevel); // prints false
print(settings.logLevel); // prints null
```

## Documentation
The documentation is available on pub.dev:
- [settings_annotation](https://pub.dev/documentation/settings_annotation/latest/)
- [settings_builder](https://pub.dev/documentation/settings_builder/latest/)
