// ignore_for_file: discarded_futures

import 'package:test/test.dart';

import '../models/base/simple_default.dart';
import '../models/root/simple_default.dart';
import '../test_helpers.dart';

void main() {
  group('SimpleDefault', () {
    testRoot<SimpleDefault>(
      'root',
      createSut: SimpleDefault.new,
      sutClear: (sut) => sut.clear(),
      sutReload: (sut) => sut.reload(),
    );

    testSettingsEntry<SimpleDefault, bool, bool>(
      'boolValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.boolValueKey,
      sutHasValue: (sut) => sut.hasBoolValue,
      sutValue: (sut) => sut.boolValue,
      sutSetValue: (sut, v) => sut.setBoolValue(v),
      sutRemoveValue: (sut) => sut.removeBoolValue(),
      testValue: false,
      defaultValue: true,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: false,
    );

    testSettingsEntry<SimpleDefault, int, int>(
      'intValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.intValueKey,
      sutHasValue: (sut) => sut.hasIntValue,
      sutValue: (sut) => sut.intValue,
      sutSetValue: (sut, v) => sut.setIntValue(v),
      sutRemoveValue: (sut) => sut.removeIntValue(),
      testValue: 0,
      defaultValue: 1,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 0,
    );

    testSettingsEntry<SimpleDefault, double, double>(
      'doubleValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.doubleValueKey,
      sutHasValue: (sut) => sut.hasDoubleValue,
      sutValue: (sut) => sut.doubleValue,
      sutSetValue: (sut, v) => sut.setDoubleValue(v),
      sutRemoveValue: (sut) => sut.removeDoubleValue(),
      testValue: 0.0,
      defaultValue: 0.1,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 0.0,
    );

    testSettingsEntry<SimpleDefault, num, double>(
      'numValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.numValueKey,
      sutHasValue: (sut) => sut.hasNumValue,
      sutValue: (sut) => sut.numValue,
      sutSetValue: (sut, v) => sut.setNumValue(v),
      sutRemoveValue: (sut) => sut.removeNumValue(),
      testValue: 0,
      defaultValue: 2,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 0.0,
    );

    testSettingsEntry<SimpleDefault, String, String>(
      'stringValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.stringValueKey,
      sutHasValue: (sut) => sut.hasStringValue,
      sutValue: (sut) => sut.stringValue,
      sutSetValue: (sut, v) => sut.setStringValue(v),
      sutRemoveValue: (sut) => sut.removeStringValue(),
      testValue: '',
      defaultValue: 'default',
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: '',
    );

    testSettingsEntry<SimpleDefault, List<String>, List<String>>(
      'stringListValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.stringListValueKey,
      sutHasValue: (sut) => sut.hasStringListValue,
      sutValue: (sut) => sut.stringListValue,
      sutSetValue: (sut, v) => sut.setStringListValue(v),
      sutRemoveValue: (sut) => sut.removeStringListValue(),
      testValue: const [],
      defaultValue: const ['a', 'b'],
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const [],
    );

    testSettingsEntry<SimpleDefault, SimpleDefaultEnum, String>(
      'enumValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.enumValueKey,
      sutHasValue: (sut) => sut.hasEnumValue,
      sutValue: (sut) => sut.enumValue,
      sutSetValue: (sut, v) => sut.setEnumValue(v),
      sutRemoveValue: (sut) => sut.removeEnumValue(),
      testValue: SimpleDefaultEnum.value1,
      defaultValue: SimpleDefaultEnum.value3,
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: SimpleDefaultEnum.value1.name,
    );
  });
}
