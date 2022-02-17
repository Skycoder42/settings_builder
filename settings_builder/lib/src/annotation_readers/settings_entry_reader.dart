// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../extensions.dart';

@internal
class SettingsEntryReader {
  final ConstantReader constantReader;

  const SettingsEntryReader(this.constantReader);

  String? get key => constantReader.maybeReadString('key');

  ConstantReader get defaultValue => constantReader.maybeRead('defaultValue');

  ExecutableElement? get toSettings => constantReader.maybeReadFn('toSettings');

  ExecutableElement? get fromSettings =>
      constantReader.maybeReadFn('fromSettings');
}
