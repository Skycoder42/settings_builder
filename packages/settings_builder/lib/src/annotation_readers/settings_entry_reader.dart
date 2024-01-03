// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:settings_annotation/settings_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions/constant_reader_x.dart';

@internal
class SettingsEntryReader {
  static final _defaultValueRegExp = RegExp(
    r'defaultValue:\s*(.+)(?:,\s*key:|,\s*toSettings:|,\s*fromSettings:|\s*\))',
  );

  final ConstantReader constantReader;

  const SettingsEntryReader(this.constantReader);

  String? get key => constantReader.maybeReadString('key');

  String? get defaultValue {
    // check if it is a DefaultValue
    final defaultValueReader = constantReader.maybeRead('defaultValue');
    if (defaultValueReader
        .instanceOf(const TypeChecker.fromRuntime(LiteralDefault))) {
      final revived = defaultValueReader.revive();
      return revived.positionalArguments.first.toStringValue();
    }

    // Otherwise extract the source code
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
