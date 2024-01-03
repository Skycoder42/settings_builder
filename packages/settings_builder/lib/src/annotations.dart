// ignore_for_file: public_member_api_docs

import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

@internal
abstract base class Annotations {
  Annotations._();

  static const override = Reference('override');
}
