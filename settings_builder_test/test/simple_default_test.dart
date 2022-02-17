import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'model/simple_default.dart';
import 'test_helpers.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('SimpleDefault', () {
    final mockSharedPreferences = MockSharedPreferences();

    late SimpleDefault sut;

    setUp(() {
      reset(mockSharedPreferences);

      sut = SimpleDefault(mockSharedPreferences);
    });

    testSettingsEntry<bool, bool>(
      'boolValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.boolValueKey,
      sutHasValue: () => sut.hasBoolValue,
      sutValue: () => sut.boolValue,
      sutSetValue: (v) => sut.setBoolValue(v),
      sutRemoveValue: () => sut.removeBoolValue(),
      testValue: false,
      defaultValue: true,
      mockSpGet: mockSharedPreferences.getBool,
      mockSpSet: mockSharedPreferences.setBool,
      mockSpValue: false,
    );

    testSettingsEntry<int, int>(
      'intValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.intValueKey,
      sutHasValue: () => sut.hasIntValue,
      sutValue: () => sut.intValue,
      sutSetValue: (v) => sut.setIntValue(v),
      sutRemoveValue: () => sut.removeIntValue(),
      testValue: 0,
      defaultValue: 1,
      mockSpGet: mockSharedPreferences.getInt,
      mockSpSet: mockSharedPreferences.setInt,
      mockSpValue: 0,
    );

    testSettingsEntry<double, double>(
      'doubleValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.doubleValueKey,
      sutHasValue: () => sut.hasDoubleValue,
      sutValue: () => sut.doubleValue,
      sutSetValue: (v) => sut.setDoubleValue(v),
      sutRemoveValue: () => sut.removeDoubleValue(),
      testValue: 0.0,
      defaultValue: 0.1,
      mockSpGet: mockSharedPreferences.getDouble,
      mockSpSet: mockSharedPreferences.setDouble,
      mockSpValue: 0.0,
    );

    testSettingsEntry<num, double>(
      'numValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.numValueKey,
      sutHasValue: () => sut.hasNumValue,
      sutValue: () => sut.numValue,
      sutSetValue: (v) => sut.setNumValue(v),
      sutRemoveValue: () => sut.removeNumValue(),
      testValue: 0,
      defaultValue: 2,
      mockSpGet: mockSharedPreferences.getDouble,
      mockSpSet: mockSharedPreferences.setDouble,
      mockSpValue: 0.0,
    );

    testSettingsEntry<String, String>(
      'stringValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.stringValueKey,
      sutHasValue: () => sut.hasStringValue,
      sutValue: () => sut.stringValue,
      sutSetValue: (v) => sut.setStringValue(v),
      sutRemoveValue: () => sut.removeStringValue(),
      testValue: '',
      defaultValue: 'default',
      mockSpGet: mockSharedPreferences.getString,
      mockSpSet: mockSharedPreferences.setString,
      mockSpValue: '',
    );

    testSettingsEntry<List<String>, List<String>>(
      'stringListValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.stringListValueKey,
      sutHasValue: () => sut.hasStringListValue,
      sutValue: () => sut.stringListValue,
      sutSetValue: (v) => sut.setStringListValue(v),
      sutRemoveValue: () => sut.removeStringListValue(),
      testValue: const [],
      defaultValue: const ['a', 'b'],
      mockSpGet: mockSharedPreferences.getStringList,
      mockSpSet: mockSharedPreferences.setStringList,
      mockSpValue: const [],
    );

    testSettingsEntry<SimpleDefaultEnum, String>(
      'enumValue',
      mockSp: mockSharedPreferences,
      sutValueKey: () => sut.enumValueKey,
      sutHasValue: () => sut.hasEnumValue,
      sutValue: () => sut.enumValue,
      sutSetValue: (v) => sut.setEnumValue(v),
      sutRemoveValue: () => sut.removeEnumValue(),
      testValue: SimpleDefaultEnum.value1,
      defaultValue: SimpleDefaultEnum.value3,
      mockSpGet: mockSharedPreferences.getString,
      mockSpSet: mockSharedPreferences.setString,
      mockSpValue: SimpleDefaultEnum.value1.name,
    );
  });
}
