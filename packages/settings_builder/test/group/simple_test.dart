// ignore_for_file: discarded_futures

import 'package:test/test.dart';

import '../models/base/simple.dart';
import '../models/group/simple.dart';
import '../test_helpers.dart';

void main() {
  group('SimpleGroup', () {
    testRoot<Simple>(
      'root',
      createSut: Simple.new,
      sutClear: (sut) => sut.clear(),
      sutReload: (sut) => sut.reload(),
    );

    testSettingsEntry<Simple, bool, bool>(
      'simple.boolValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.boolValueKey,
      sutHasValue: (sut) => sut.simple.hasBoolValue,
      sutValue: (sut) => sut.simple.boolValue,
      sutSetValue: (sut, v) => sut.simple.setBoolValue(v),
      sutRemoveValue: (sut) => sut.simple.removeBoolValue(),
      testValue: true,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<Simple, int, int>(
      'simple.intValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.intValueKey,
      sutHasValue: (sut) => sut.simple.hasIntValue,
      sutValue: (sut) => sut.simple.intValue,
      sutSetValue: (sut, v) => sut.simple.setIntValue(v),
      sutRemoveValue: (sut) => sut.simple.removeIntValue(),
      testValue: 42,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 42,
    );

    testSettingsEntry<Simple, double, double>(
      'simple.doubleValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.doubleValueKey,
      sutHasValue: (sut) => sut.simple.hasDoubleValue,
      sutValue: (sut) => sut.simple.doubleValue,
      sutSetValue: (sut, v) => sut.simple.setDoubleValue(v),
      sutRemoveValue: (sut) => sut.simple.removeDoubleValue(),
      testValue: 4.2,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 4.2,
    );

    testSettingsEntry<Simple, num, double>(
      'simple.numValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.numValueKey,
      sutHasValue: (sut) => sut.simple.hasNumValue,
      sutValue: (sut) => sut.simple.numValue,
      sutSetValue: (sut, v) => sut.simple.setNumValue(v),
      sutRemoveValue: (sut) => sut.simple.removeNumValue(),
      testValue: 42,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 42.0,
    );

    testSettingsEntry<Simple, String, String>(
      'simple.stringValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.stringValueKey,
      sutHasValue: (sut) => sut.simple.hasStringValue,
      sutValue: (sut) => sut.simple.stringValue,
      sutSetValue: (sut, v) => sut.simple.setStringValue(v),
      sutRemoveValue: (sut) => sut.simple.removeStringValue(),
      testValue: 'hello world',
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: 'hello world',
    );

    testSettingsEntry<Simple, List<String>, List<String>>(
      'simple.stringListValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.stringListValueKey,
      sutHasValue: (sut) => sut.simple.hasStringListValue,
      sutValue: (sut) => sut.simple.stringListValue,
      sutSetValue: (sut, v) => sut.simple.setStringListValue(v),
      sutRemoveValue: (sut) => sut.simple.removeStringListValue(),
      testValue: const ['hello', 'world'],
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const ['hello', 'world'],
    );

    testSettingsEntry<Simple, SimpleEnum, String>(
      'simple.enumValue',
      createSut: Simple.new,
      sutValueKey: (sut) => sut.simple.enumValueKey,
      sutHasValue: (sut) => sut.simple.hasEnumValue,
      sutValue: (sut) => sut.simple.enumValue,
      sutSetValue: (sut, v) => sut.simple.setEnumValue(v),
      sutRemoveValue: (sut) => sut.simple.removeEnumValue(),
      testValue: SimpleEnum.value2,
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: SimpleEnum.value2.name,
    );
  });
}
