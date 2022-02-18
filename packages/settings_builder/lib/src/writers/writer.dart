import 'package:meta/meta.dart';

/// @nodoc
@internal
abstract class Writer {
  Writer._();

  /// @nodoc
  void call(StringBuffer buffer);
}
