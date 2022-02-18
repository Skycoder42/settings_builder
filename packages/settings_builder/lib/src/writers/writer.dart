// ignore_for_file: public_member_api_docs

import 'package:meta/meta.dart';

@internal
abstract class Writer {
  Writer._();

  void call(StringBuffer buffer);
}
