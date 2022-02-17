import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'models/simple.dart';
import 'test_helpers.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('Simple', () {
    final mockSharedPreferences = MockSharedPreferences();

    late Simple sut;

    setUp(() {
      reset(mockSharedPreferences);

      sut = Simple(mockSharedPreferences);
    });

    testSettingsEntry<bool, bool>(
      'boolValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.boolValueKey,
      sutHasValue: () => sut.hasBoolValue,
      sutValue: () => sut.boolValue,
      sutSetValue: (v) => sut.setBoolValue(v),
      sutRemoveValue: () => sut.removeBoolValue(),
      testValue: true,
      mockSpGet: mockSharedPreferences.getBool,
      mockSpSet: mockSharedPreferences.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<int, int>(
      'intValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.intValueKey,
      sutHasValue: () => sut.hasIntValue,
      sutValue: () => sut.intValue,
      sutSetValue: (v) => sut.setIntValue(v),
      sutRemoveValue: () => sut.removeIntValue(),
      testValue: 42,
      mockSpGet: mockSharedPreferences.getInt,
      mockSpSet: mockSharedPreferences.setInt,
      mockSpValue: 42,
    );

    testSettingsEntry<double, double>(
      'doubleValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.doubleValueKey,
      sutHasValue: () => sut.hasDoubleValue,
      sutValue: () => sut.doubleValue,
      sutSetValue: (v) => sut.setDoubleValue(v),
      sutRemoveValue: () => sut.removeDoubleValue(),
      testValue: 4.2,
      mockSpGet: mockSharedPreferences.getDouble,
      mockSpSet: mockSharedPreferences.setDouble,
      mockSpValue: 4.2,
    );

    testSettingsEntry<num, double>(
      'numValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.numValueKey,
      sutHasValue: () => sut.hasNumValue,
      sutValue: () => sut.numValue,
      sutSetValue: (v) => sut.setNumValue(v),
      sutRemoveValue: () => sut.removeNumValue(),
      testValue: 42,
      mockSpGet: mockSharedPreferences.getDouble,
      mockSpSet: mockSharedPreferences.setDouble,
      mockSpValue: 42.0,
    );

    testSettingsEntry<String, String>(
      'stringValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.stringValueKey,
      sutHasValue: () => sut.hasStringValue,
      sutValue: () => sut.stringValue,
      sutSetValue: (v) => sut.setStringValue(v),
      sutRemoveValue: () => sut.removeStringValue(),
      testValue: 'hello world',
      mockSpGet: mockSharedPreferences.getString,
      mockSpSet: mockSharedPreferences.setString,
      mockSpValue: 'hello world',
    );

    testSettingsEntry<List<String>, List<String>>(
      'stringListValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.stringListValueKey,
      sutHasValue: () => sut.hasStringListValue,
      sutValue: () => sut.stringListValue,
      sutSetValue: (v) => sut.setStringListValue(v),
      sutRemoveValue: () => sut.removeStringListValue(),
      testValue: const ['hello', 'world'],
      mockSpGet: mockSharedPreferences.getStringList,
      mockSpSet: mockSharedPreferences.setStringList,
      mockSpValue: const ['hello', 'world'],
    );

    testSettingsEntry<SimpleEnum, String>(
      'enumValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.enumValueKey,
      sutHasValue: () => sut.hasEnumValue,
      sutValue: () => sut.enumValue,
      sutSetValue: (v) => sut.setEnumValue(v),
      sutRemoveValue: () => sut.removeEnumValue(),
      testValue: SimpleEnum.value2,
      mockSpGet: mockSharedPreferences.getString,
      mockSpSet: mockSharedPreferences.setString,
      mockSpValue: SimpleEnum.value2.name,
    );
  });
  group('Simple with prefix', () {
    const prefix = 'test-prefix';
    final mockSharedPreferences = MockSharedPreferences();

    late Simple sut;

    setUp(() {
      reset(mockSharedPreferences);

      sut = Simple(mockSharedPreferences, prefix);
    });

    testSettingsEntry<bool, bool>(
      '$prefix.boolValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.boolValueKey,
      sutHasValue: () => sut.hasBoolValue,
      sutValue: () => sut.boolValue,
      sutSetValue: (v) => sut.setBoolValue(v),
      sutRemoveValue: () => sut.removeBoolValue(),
      testValue: true,
      mockSpGet: mockSharedPreferences.getBool,
      mockSpSet: mockSharedPreferences.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<int, int>(
      '$prefix.intValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.intValueKey,
      sutHasValue: () => sut.hasIntValue,
      sutValue: () => sut.intValue,
      sutSetValue: (v) => sut.setIntValue(v),
      sutRemoveValue: () => sut.removeIntValue(),
      testValue: 42,
      mockSpGet: mockSharedPreferences.getInt,
      mockSpSet: mockSharedPreferences.setInt,
      mockSpValue: 42,
    );

    testSettingsEntry<double, double>(
      '$prefix.doubleValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.doubleValueKey,
      sutHasValue: () => sut.hasDoubleValue,
      sutValue: () => sut.doubleValue,
      sutSetValue: (v) => sut.setDoubleValue(v),
      sutRemoveValue: () => sut.removeDoubleValue(),
      testValue: 4.2,
      mockSpGet: mockSharedPreferences.getDouble,
      mockSpSet: mockSharedPreferences.setDouble,
      mockSpValue: 4.2,
    );

    testSettingsEntry<num, double>(
      '$prefix.numValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.numValueKey,
      sutHasValue: () => sut.hasNumValue,
      sutValue: () => sut.numValue,
      sutSetValue: (v) => sut.setNumValue(v),
      sutRemoveValue: () => sut.removeNumValue(),
      testValue: 42,
      mockSpGet: mockSharedPreferences.getDouble,
      mockSpSet: mockSharedPreferences.setDouble,
      mockSpValue: 42.0,
    );

    testSettingsEntry<String, String>(
      '$prefix.stringValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.stringValueKey,
      sutHasValue: () => sut.hasStringValue,
      sutValue: () => sut.stringValue,
      sutSetValue: (v) => sut.setStringValue(v),
      sutRemoveValue: () => sut.removeStringValue(),
      testValue: 'hello world',
      mockSpGet: mockSharedPreferences.getString,
      mockSpSet: mockSharedPreferences.setString,
      mockSpValue: 'hello world',
    );

    testSettingsEntry<List<String>, List<String>>(
      '$prefix.stringListValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.stringListValueKey,
      sutHasValue: () => sut.hasStringListValue,
      sutValue: () => sut.stringListValue,
      sutSetValue: (v) => sut.setStringListValue(v),
      sutRemoveValue: () => sut.removeStringListValue(),
      testValue: const ['hello', 'world'],
      mockSpGet: mockSharedPreferences.getStringList,
      mockSpSet: mockSharedPreferences.setStringList,
      mockSpValue: const ['hello', 'world'],
    );

    testSettingsEntry<SimpleEnum, String>(
      '$prefix.enumValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.enumValueKey,
      sutHasValue: () => sut.hasEnumValue,
      sutValue: () => sut.enumValue,
      sutSetValue: (v) => sut.setEnumValue(v),
      sutRemoveValue: () => sut.removeEnumValue(),
      testValue: SimpleEnum.value2,
      mockSpGet: mockSharedPreferences.getString,
      mockSpSet: mockSharedPreferences.setString,
      mockSpValue: SimpleEnum.value2.name,
    );
  });
}
