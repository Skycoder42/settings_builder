// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../extensions.dart';
import '../writer.dart';
import 'implementation_writer.dart';

@internal
class EntrySetterWriter implements Writer {
  static const _valueName = r'$value';

  final PropertyAccessorElement getter;
  final SettingsEntryReader settingsEntry;
  final String entryKeyName;

  const EntrySetterWriter({
    required this.getter,
    required this.settingsEntry,
    required this.entryKeyName,
  });

  @override
  void call(StringBuffer buffer) {
    final setterType = getter.returnType.baseTypeName;

    buffer
      ..writeln('@override')
      ..write(
        'Future<bool> set${getter.name.pascal}($setterType $_valueName) => ',
      );

    final toSettings = settingsEntry.toSettings;
    if (toSettings != null) {
      _writeToSettings(buffer, toSettings);
    } else if (getter.returnType.isEnum) {
      _writeEnum(buffer);
    } else if (getter.returnType.isDartCoreNum) {
      _writeNum(buffer);
    } else {
      _writeDirect(buffer);
    }

    buffer
      ..write(';')
      ..writeln();
  }

  void _writeDirect(StringBuffer buffer) =>
      _writeSpSet(buffer, getter.returnType, _valueName);

  void _writeNum(StringBuffer buffer) =>
      _writeSpSet(buffer, getter.returnType, '$_valueName.toDouble()');

  void _writeEnum(StringBuffer buffer) =>
      _writeSpSet(buffer, getter.returnType, '$_valueName.name');

  void _writeToSettings(StringBuffer buffer, ExecutableElement toSettings) {
    if (toSettings.parameters.isEmpty) {
      throw InvalidGenerationSourceError(
        'Invalid toSettings function. '
        'Must accept at least one parmeter',
        element: getter,
      );
    }

    final parameter = toSettings.parameters.first;
    if (!parameter.isPositional) {
      throw InvalidGenerationSourceError(
        'Invalid toSettings function. '
        'Must accept a single positional parmeter',
        element: getter,
      );
    }

    if (!parameter.type.isAssignableTo(getter.returnType)) {
      throw InvalidGenerationSourceError(
        'Invalid toSettings function. '
        'Must accept a single positional parmeter that can be called with '
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

    var toSettingsName = '';
    if (toSettings is MethodElement) {
      toSettingsName = '${toSettings.enclosingElement.name}.';
    }
    toSettingsName += toSettings.name;

    _writeSpSet(buffer, toSettings.returnType, '$toSettingsName($_valueName),');
  }

  void _writeSpSet(StringBuffer buffer, DartType settingsType, String value) {
    buffer.write('${ImplementationWriter.spKey}.');

    if (settingsType.isDartCoreBool) {
      buffer.write('setBool(');
    } else if (settingsType.isDartCoreInt) {
      buffer.write('setInt(');
    } else if (settingsType.isDartCoreNum || settingsType.isDartCoreDouble) {
      buffer.write('setDouble(');
    } else if (settingsType.isDartCoreString || settingsType.isEnum) {
      buffer.write('setString(');
    } else if (settingsType.isDartCoreList) {
      final args =
          settingsType.typeArgumentsOf(const TypeChecker.fromRuntime(List));
      if (args != null && args.length == 1 && args.first.isDartCoreString) {
        buffer.write('setStringList(');
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

    buffer.write('$entryKeyName, $value)');
  }
}
