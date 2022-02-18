import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/settings_generator.dart';

Builder settingsBuilder(BuilderOptions options) => SharedPartBuilder(
      [SettingsGenerator(options)],
      'settings',
      // formatOutput: (code) => code,
    );
