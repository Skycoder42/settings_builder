// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../../annotation_readers/settings_entry_reader.dart';
import '../../extensions/dart_type_x.dart';
import '../writer.dart';
import 'implementation_writer.dart';

@internal
class EntryGetterWriter implements Writer {
  static const _valueName = r'$value';

  final PropertyAccessorElement getter;
  final SettingsEntryReader settingsEntry;
  final String entryKeyName;

  const EntryGetterWriter({
    required this.getter,
    required this.settingsEntry,
    required this.entryKeyName,
  });

  @override
  void call(StringBuffer buffer) {
    buffer
      ..writeln('@override')
      ..write('${getter.returnType} get ${getter.name} ');

    final fromSettings = settingsEntry.fromSettings;
    if (fromSettings != null) {
      _writeFromSettings(buffer, fromSettings);
    } else if (getter.returnType.isEnum) {
      _writeEnum(buffer);
    } else {
      _writeDirect(buffer);
    }

    buffer.writeln();
  }

  void _writeDirect(StringBuffer buffer) {
    buffer.write('=> ');

    _writeSpGet(buffer, getter.returnType);

    final defaultValue = settingsEntry.defaultValue;
    if (defaultValue != null) {
      buffer.write(' ?? $defaultValue');
    }

    buffer.write(';');
  }

  void _writeEnum(StringBuffer buffer) => _writeWrapped(
        buffer,
        getter.returnType,
        (buffer) {
          final enumName = getter.returnType.baseTypeName;
          buffer.writeln('$enumName.values.byName($_valueName)');
        },
      );

  void _writeFromSettings(StringBuffer buffer, ExecutableElement fromSettings) {
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
        'Must accept at least one parmeter',
        element: getter,
      );
    }

    final parameter = fromSettings.parameters.first;
    if (!parameter.isPositional) {
      throw InvalidGenerationSourceError(
        'Invalid fromSettings function. '
        'Must accept a single positional parmeter',
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

    _writeWrapped(buffer, parameter.type, (buffer) {
      if (fromSettings is MethodElement) {
        buffer.write('${fromSettings.enclosingElement.name}.');
      }

      buffer.write('${fromSettings.name}($_valueName)');
    });
  }

  void _writeWrapped(
    StringBuffer buffer,
    DartType spType,
    void Function(StringBuffer buffer) writeConvert,
  ) {
    buffer
      ..writeln('{')
      ..write('final $_valueName = ');

    _writeSpGet(buffer, spType);

    buffer
      ..writeln(';')
      ..writeln('return $_valueName != null ? ');

    writeConvert(buffer);

    buffer.write(' : ');

    final defaultValue = settingsEntry.defaultValue;
    if (defaultValue != null) {
      buffer.write(defaultValue);
    } else {
      buffer.write(null);
    }

    buffer
      ..writeln(';')
      ..writeln('}');
  }

  void _writeSpGet(StringBuffer buffer, DartType settingsType) {
    buffer.write('${ImplementationWriter.spKey}.');

    if (settingsType.isDartCoreBool) {
      buffer.write('getBool(');
    } else if (settingsType.isDartCoreInt) {
      buffer.write('getInt(');
    } else if (settingsType.isDartCoreNum || settingsType.isDartCoreDouble) {
      buffer.write('getDouble(');
    } else if (settingsType.isDartCoreString || settingsType.isEnum) {
      buffer.write('getString(');
    } else if (settingsType.isDartCoreList) {
      final args =
          settingsType.typeArgumentsOf(const TypeChecker.fromRuntime(List));
      if (args != null && args.length == 1 && args.first.isDartCoreString) {
        buffer.write('getStringList(');
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

    buffer.write('$entryKeyName)');
  }
}
