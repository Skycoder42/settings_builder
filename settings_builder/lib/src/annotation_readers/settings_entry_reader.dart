// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';

@internal
class SettingsEntryReader {
  static late final _defaultValueRegExp = RegExp(
    r'defaultValue:\s*(.+)(?:,\s*key:|,\s*toSettings:|,\s*fromSettings:|\s*\))',
  );

  final ConstantReader constantReader;

  const SettingsEntryReader(this.constantReader);

  String? get key => constantReader.maybeReadString('key');

  String? get defaultValue {
    final source = constantReader.toSource();
    if (source == null) {
      return null;
    }

    final match = _defaultValueRegExp.firstMatch(source);
    if (match == null) {
      return null;
    }

    return match[1];
  }

  ExecutableElement? get toSettings => constantReader.maybeReadFn('toSettings');

  ExecutableElement? get fromSettings =>
      constantReader.maybeReadFn('fromSettings');
}
