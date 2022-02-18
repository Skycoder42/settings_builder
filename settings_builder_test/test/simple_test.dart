import 'package:test/test.dart';

import 'models/simple.dart';
import 'test_helpers.dart';

void main() {
  group('Simple', () {
    testSettingsEntry<Simple, bool, bool>(
      'boolValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.boolValueKey,
      sutHasValue: (sut) => sut.hasBoolValue,
      sutValue: (sut) => sut.boolValue,
      sutSetValue: (sut, v) => sut.setBoolValue(v),
      sutRemoveValue: (sut) => sut.removeBoolValue(),
      testValue: true,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<Simple, int, int>(
      'intValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.intValueKey,
      sutHasValue: (sut) => sut.hasIntValue,
      sutValue: (sut) => sut.intValue,
      sutSetValue: (sut, v) => sut.setIntValue(v),
      sutRemoveValue: (sut) => sut.removeIntValue(),
      testValue: 42,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 42,
    );

    testSettingsEntry<Simple, double, double>(
      'doubleValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.doubleValueKey,
      sutHasValue: (sut) => sut.hasDoubleValue,
      sutValue: (sut) => sut.doubleValue,
      sutSetValue: (sut, v) => sut.setDoubleValue(v),
      sutRemoveValue: (sut) => sut.removeDoubleValue(),
      testValue: 4.2,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 4.2,
    );

    testSettingsEntry<Simple, num, double>(
      'numValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.numValueKey,
      sutHasValue: (sut) => sut.hasNumValue,
      sutValue: (sut) => sut.numValue,
      sutSetValue: (sut, v) => sut.setNumValue(v),
      sutRemoveValue: (sut) => sut.removeNumValue(),
      testValue: 42,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 42.0,
    );

    testSettingsEntry<Simple, String, String>(
      'stringValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.stringValueKey,
      sutHasValue: (sut) => sut.hasStringValue,
      sutValue: (sut) => sut.stringValue,
      sutSetValue: (sut, v) => sut.setStringValue(v),
      sutRemoveValue: (sut) => sut.removeStringValue(),
      testValue: 'hello world',
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: 'hello world',
    );

    testSettingsEntry<Simple, List<String>, List<String>>(
      'stringListValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.stringListValueKey,
      sutHasValue: (sut) => sut.hasStringListValue,
      sutValue: (sut) => sut.stringListValue,
      sutSetValue: (sut, v) => sut.setStringListValue(v),
      sutRemoveValue: (sut) => sut.removeStringListValue(),
      testValue: const ['hello', 'world'],
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const ['hello', 'world'],
    );

    testSettingsEntry<Simple, SimpleEnum, String>(
      'enumValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.enumValueKey,
      sutHasValue: (sut) => sut.hasEnumValue,
      sutValue: (sut) => sut.enumValue,
      sutSetValue: (sut, v) => sut.setEnumValue(v),
      sutRemoveValue: (sut) => sut.removeEnumValue(),
      testValue: SimpleEnum.value2,
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: SimpleEnum.value2.name,
    );
  });
}
