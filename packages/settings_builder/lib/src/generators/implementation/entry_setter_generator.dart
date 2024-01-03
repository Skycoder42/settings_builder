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
class EntrySetterGenerator {
  static const _value = r'$value';
  static const _valueRef = Reference(_value);

  final PropertyAccessorElement getter;
  final SettingsEntryReader settingsEntry;

  const EntrySetterGenerator({
    required this.getter,
    required this.settingsEntry,
  });

  Method build() => Method(
        (b) {
          b
            ..name = Signatures.setEntry(getter)
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = _value
                  ..type = Types.fromDartType(getter.returnType, isNull: false),
              ),
            )
            ..returns = Types.futureBool
            ..annotations.add(Annotations.override)
            ..lambda = true;

          final toSettings = settingsEntry.toSettings;
          if (toSettings != null) {
            b.body = _buildToSettings(b, toSettings).code;
          } else if (getter.returnType.isEnum) {
            b.body = _buildEnum(b).code;
          } else if (getter.returnType.isDartCoreNum) {
            b.body = _buildNum(b).code;
          } else {
            b.body = _buildDirect(b).code;
          }
        },
      );

  Expression _buildDirect(MethodBuilder b) =>
      _spSet(getter.returnType, _valueRef);

  Expression _buildNum(MethodBuilder b) => _spSet(
        getter.returnType,
        _valueRef.property('toDouble').call(const []),
      );

  Expression _buildEnum(MethodBuilder b) =>
      _spSet(getter.returnType, _valueRef.property('name'));

  Expression _buildToSettings(MethodBuilder b, ExecutableElement toSettings) {
    if (toSettings.parameters.isEmpty) {
      throw InvalidGenerationSourceError(
        'Invalid toSettings function. '
        'Must accept at least one parameter',
        element: getter,
      );
    }

    final parameter = toSettings.parameters.first;
    if (!parameter.isPositional) {
      throw InvalidGenerationSourceError(
        'Invalid toSettings function. '
        'Must accept a single positional parameter',
        element: getter,
      );
    }

    if (!parameter.type.isAssignableTo(getter.returnType)) {
      throw InvalidGenerationSourceError(
        'Invalid toSettings function. '
        'Must accept a single positional parameter that can be called with '
        'a value of the same type as the defined getter (not nullable)',
        element: getter,
      );
    }

    for (final otherParam in toSettings.parameters.skip(1)) {
      if (!otherParam.isOptional) {
        throw InvalidGenerationSourceError(
          'Invalid toSettings function. '
          'Can only have a single required positional parameter. '
          'All other parameters must be optional',
          element: getter,
        );
      }
    }

    return _spSet(
      toSettings.returnType,
      toSettings.funcExpr.call([_valueRef]),
    );
  }

  Expression _spSet(DartType settingsType, Expression value) {
    Expression spSet = Signatures.sharedPreferencesRef;

    if (settingsType.isDartCoreBool) {
      spSet = spSet.property('setBool');
    } else if (settingsType.isDartCoreInt) {
      spSet = spSet.property('setInt');
    } else if (settingsType.isDartCoreNum || settingsType.isDartCoreDouble) {
      spSet = spSet.property('setDouble');
    } else if (settingsType.isDartCoreString || settingsType.isEnum) {
      spSet = spSet.property('setString');
    } else if (settingsType.isDartCoreList) {
      final args =
          settingsType.typeArgumentsOf(const TypeChecker.fromRuntime(List));
      if (args != null && args.length == 1 && args.first.isDartCoreString) {
        spSet = spSet.property('setStringList');
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

    return spSet.call([Signatures.entryKeyRef(getter), value]);
  }
}
