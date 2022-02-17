import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import '../../settings_builder.dart';

class SettingsGenerator extends GeneratorForAnnotation<SettingsGroup> {
  static const groupKeyName = 'groupKey';

  final BuilderOptions builderOptions;

  const SettingsGenerator(this.builderOptions);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'The $SettingsGroup annotation can only be used on classes',
        element: element,
      );
    }

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError(
        'The $SettingsGroup annotation can only be used on abstract classes',
        element: element,
      );
    }

    final buffer = StringBuffer();
    _writeMixin(buffer, element, annotation);
    _writeImplementation(buffer, element, annotation);
    return buffer.toString();
  }

  void _writeMixin(
    StringBuffer buffer,
    ClassElement clazz,
    ConstantReader settingsGroup,
  ) {
    final mixinName = '_\$${clazz.name}';
    buffer.writeln('mixin $mixinName {');

    _writeMixinCommon(settingsGroup, buffer);

    for (final getter in clazz.abstractGetters) {
      final returnType = getter.returnType;

      if (returnType.hasAnnotation<SettingsGroup>()) {
        // do not generate set/remove for sub-groups
        continue;
      }

      _writeEntryMembers(buffer, getter, returnType);
    }

    buffer.writeln('} // $mixinName');
  }

  void _writeMixinCommon(ConstantReader settingsGroup, StringBuffer buffer) {
    if (settingsGroup.read('root').boolValue) {
      buffer
        ..writeln('String? get prefix;')
        ..writeln()
        ..writeln('Future<bool> clear();')
        ..writeln();
    } else {
      buffer
        ..writeln('String get $groupKeyName;')
        ..writeln();
    }
  }

  void _writeEntryMembers(
    StringBuffer buffer,
    PropertyAccessorElement getter,
    DartType returnType,
  ) =>
      buffer
        ..writeln('String get ${getter.name}Key;')
        ..writeln()
        ..writeln('bool get has${getter.name.pascal};')
        ..writeln()
        ..writeln(
          'Future<bool> set${getter.name.pascal}(${returnType.getDisplayString(withNullability: false)} value);',
        )
        ..writeln()
        ..writeln('Future<bool> remove${getter.name.pascal}();')
        ..writeln();

  void _writeImplementation(
    StringBuffer buffer,
    ClassElement clazz,
    ConstantReader settingsGroup,
  ) {
    final isRoot = settingsGroup.read('root').boolValue;

    final implClassName = '_\$${clazz.name}Impl';
    buffer.writeln('class $implClassName implements ${clazz.name} {');
    _writeCommonImpl(buffer, isRoot);

    for (final getter in clazz.abstractGetters) {
      if (getter.returnType.hasAnnotation<SettingsGroup>()) {
      } else {
        _writeEntryImpl(
          buffer: buffer,
          getter: getter,
          isRoot: isRoot,
        );
      }
    }

    buffer.writeln('} // $implClassName');
  }

  void _writeCommonImpl(StringBuffer buffer, bool isRoot) {
    buffer
      ..writeln('final SharedPreferences _sharedPreferences;')
      ..writeln();

    if (isRoot) {
      buffer
        ..writeln('@override')
        ..writeln('final String? prefix;')
        ..writeln();
    } else {
      buffer
        ..writeln('@override')
        ..writeln('final String $groupKeyName;')
        ..writeln();
    }
  }

  void _writeEntryImpl({
    required StringBuffer buffer,
    required PropertyAccessorElement getter,
    required bool isRoot,
  }) {
    final settingsEntry = getter.getAnnotation<SettingsEntry>();

    final entryKey = settingsEntry.maybeReadString('key') ?? getter.name.snake;

    buffer
      ..writeln('@override')
      ..write("late final ${getter.name}Key = ");
    if (isRoot) {
      buffer.writeln("prefix != null ? '\$prefix.$entryKey' : '$entryKey';");
    } else {
      buffer.writeln("'\$$groupKeyName.$entryKey';");
    }
    buffer
      ..writeln()
      ..writeln('@override')
      ..writeln(
        'bool get has${getter.name.pascal} => _sharedPreferences.containsKey(${getter.name}Key);',
      )
      ..writeln()
      ..writeln('@override')
      ..write('${getter.returnType} get ${getter.name} => ');
    _writeGetMethod(
      buffer: buffer,
      getter: getter,
      settingsEntry: settingsEntry,
    );
    buffer
      ..writeln(';')
      ..writeln();
  }

  void _writeGetMethod({
    required StringBuffer buffer,
    required PropertyAccessorElement getter,
    required ConstantReader settingsEntry,
  }) {
    DartType settingsType;

    final fromSettings = settingsEntry.maybeReadFn('fromSettings');
    if (fromSettings != null) {
      if (!fromSettings.returnType.isAssignableTo(getter.returnType)) {
        throw InvalidGenerationSourceError(
          'Invalid fromSettings function. Must return the same type as the defined getter',
          element: getter,
        );
      }

      if (fromSettings.parameters.length != 1) {
        throw InvalidGenerationSourceError(
          'Invalid fromSettings function. Must accept a single, nullable parmeter',
          element: getter,
        );
      }

      settingsType = fromSettings.parameters.first.type;

      if (fromSettings is MethodElement) {
        buffer
          ..write('has${getter.name.pascal} ? ')
          ..write(
            '${fromSettings.enclosingElement.name}.${fromSettings.name}(',
          );
      } else {
        buffer.write('${fromSettings}(');
      }
    } else {
      settingsType = getter.returnType;

      if (settingsType.isEnum) {
        buffer
          ..write('has${getter.name.pascal} ? ')
          ..write(
            '${settingsType.getDisplayString(withNullability: false)}.values.byName(',
          );
      }
    }

    buffer.write('_sharedPreferences.');
    if (settingsType.isDartCoreBool) {
      buffer.write('getBool(');
    } else if (settingsType.isDartCoreInt) {
      buffer.write('getInt(');
    } else if (settingsType.isDartCoreNum || settingsType.isDartCoreDouble) {
      buffer.write('getDouble(');
    } else if (settingsType.isDartCoreString || settingsType.isEnum) {
      buffer.write('getString(');
    } else if (settingsType.isDartCoreList) {
      final args = settingsType.typeArgumentsOf(TypeChecker.fromRuntime(List));
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
        'Invalid type for getter. Only bool, int, double, String, List<String> and enums are supported',
        element: getter,
      );
    }

    buffer.write('${getter.name}Key)');
    if (fromSettings != null || settingsType.isEnum) {
      buffer.write('!,)');
    }

    final defaultValue = settingsEntry.maybeRead('defaultValue');
    if (fromSettings != null || settingsType.isEnum) {
      if (defaultValue.isNull) {
        buffer.write(' : null');
      } else {
        buffer.write(' : ${defaultValue.revive().accessor}');
      }
    } else if (!defaultValue.isNull) {
      buffer.write(' ?? ${defaultValue.literalValue}');
    }
  }
}

extension _ClassElementX on ClassElement {
  Iterable<PropertyAccessorElement> get abstractGetters =>
      accessors.where((accessor) => accessor.isGetter && accessor.isAbstract);
}

extension _DartTypeX on DartType {
  bool hasAnnotation<T>() =>
      element?.metadata
          .map((annotation) => annotation.element)
          .whereType<ConstructorElement>()
          .map((e) => e.enclosingElement)
          .any((c) => c.name == T.toString()) ??
      false;
}

extension _ElementX on Element {
  ConstantReader getAnnotation<T>() => metadata.where((annotation) {
        final element = annotation.element;
        if (element is! ConstructorElement) {
          return false;
        }
        final classElement = element.enclosingElement;
        return classElement.name == T.toString();
      }).map((a) {
        final computedValue = a.computeConstantValue();
        if (computedValue == null &&
            (a.constantEvaluationErrors?.isNotEmpty ?? false)) {
          throw InvalidGenerationSourceError(
            a.constantEvaluationErrors!.toString(),
            element: a.element,
          );
        }
        return ConstantReader(computedValue);
      }).firstWhere(
        (reader) => !reader.isNull,
        orElse: () => ConstantReader(null),
      );
}

extension ConstantReaderX on ConstantReader {
  ConstantReader maybeRead(String name) =>
      isNull ? ConstantReader(null) : read(name);

  String? maybeReadString(String name) {
    final field = maybeRead(name);
    return field.isString ? field.stringValue : null;
  }

  ExecutableElement? maybeReadFn(String name) {
    final field = maybeRead(name);
    return field.isNull ? null : field.objectValue.toFunctionValue();
  }
}
