// ignore_for_file: public_member_api_docs

import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@internal
class SettingsGroupReader {
  final ConstantReader constantReader;

  const SettingsGroupReader(this.constantReader);

  bool get root => constantReader.read('root').boolValue;

  bool get includeSuperclass =>
      constantReader.read('includeSuperclass').boolValue;
}
