// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../annotations.dart';
import '../../extensions/element_x.dart';
import '../../signatures.dart';
import '../../types.dart';

@internal
class EntryGetterGenerator {
  static const _value = r'$value';
  static const _valueRef = Reference(_value);

  final PropertyAccessorElement getter;
  final SettingsEntryReader settingsEntry;

  const EntryGetterGenerator({
    required this.getter,
    required this.settingsEntry,
  });

  Method build() => Method(
        (b) {
          b
            ..type = MethodType.getter
            ..name = Signatures.getEntry(getter)
            ..returns = Types.fromDartType(getter.returnType)
            ..annotations.add(Annotations.override);

          final fromSettings = settingsEntry.fromSettings;
          if (fromSettings != null) {
            _buildFromSettings(b, fromSettings);
          } else if (getter.returnType.isEnum) {
            _buildEnum(b);
          } else {
            _buildDirect(b);
          }
        },
      );

  void _buildDirect(MethodBuilder b) {
    var spGet = _spGet(getter.returnType);

    final defaultValue = settingsEntry.defaultValue;
    if (defaultValue != null) {
      spGet = spGet.ifNullThen(Reference(defaultValue));
    }

    b
      ..lambda = true
      ..body = spGet.code;
  }

  void _buildEnum(MethodBuilder b) {
    _buildWrapped(
      b,
      getter.returnType,
      Types.fromDartType(getter.returnType, isNull: false)
          .property('values')
          .property('byName')
          .call(const [_valueRef]),
    );
  }

  void _buildFromSettings(MethodBuilder b, ExecutableElement fromSettings) {
    if (!fromSettings.returnType.isAssignableTo(getter.returnType)) {
      throw InvalidGenerationSourceError(
        'Invalid fromSettings function. '
        'Must return a type that can be returned from the defined getter',
        element: getter,
      );
    }

    if (fromSettings.parameters.isEmpty) {
      throw InvalidGenerationSourceError(
        'Invalid fromSettings function. '
        'Must accept at least one parameter',
        element: getter,
      );
    }

    final parameter = fromSettings.parameters.first;
    if (!parameter.isPositional) {
      throw InvalidGenerationSourceError(
        'Invalid fromSettings function. '
        'Must accept a single positional parameter',
        element: getter,
      );
    }

    for (final otherParam in fromSettings.parameters.skip(1)) {
      if (!otherParam.isOptional) {
        throw InvalidGenerationSourceError(
          'Invalid fromSettings function. '
          'Can only have a single required positional parameter. '
          'All other parameters must be optional',
          element: getter,
        );
      }
    }

    _buildWrapped(
      b,
      parameter.type,
      fromSettings.funcExpr.call(const [_valueRef]),
    );
  }

  void _buildWrapped(
    MethodBuilder b,
    DartType spType,
    Expression convertExpression,
  ) {
    final defaultValue = settingsEntry.defaultValue;
    b.body = Block(
      (b) => b
        ..addExpression(declareFinal(_value).assign(_spGet(spType)))
        ..addExpression(
          _valueRef
              .notEqualTo(literalNull)
              .conditional(
                convertExpression,
                defaultValue != null ? Reference(defaultValue) : literalNull,
              )
              .returned,
        ),
    );
  }

  Expression _spGet(DartType settingsType) {
    Expression spGet = Signatures.sharedPreferencesRef;
    if (settingsType.isDartCoreBool) {
      spGet = spGet.property('getBool');
    } else if (settingsType.isDartCoreInt) {
      spGet = spGet.property('getInt');
    } else if (settingsType.isDartCoreNum || settingsType.isDartCoreDouble) {
      spGet = spGet.property('getDouble');
    } else if (settingsType.isDartCoreString || settingsType.isEnum) {
      spGet = spGet.property('getString');
    } else if (settingsType.isDartCoreList) {
      final args =
          settingsType.typeArgumentsOf(const TypeChecker.fromRuntime(List));
      if (args != null && args.length == 1 && args.first.isDartCoreString) {
        spGet = spGet.property('getStringList');
      } else {
        throw InvalidGenerationSourceError(
          'Invalid List type for getter. Only List<String> is supported',
          element: getter,
        );
      }
    } else {
      throw InvalidGenerationSourceError(
        'Invalid type for getter. '
        'Only bool, int, double, String, List<String> and enums are supported',
        element: getter,
      );
    }

    return spGet.call([Signatures.entryKeyRef(getter)]);
  }
}
