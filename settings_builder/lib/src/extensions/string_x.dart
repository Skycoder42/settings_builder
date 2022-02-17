// ignore_for_file: public_member_api_docs

import 'package:meta/meta.dart';

@internal
extension StringX on String {
  String get camel {
    if (isEmpty) {
      return '';
    }

    return this[0].toLowerCase() + substring(1);
  }
}
