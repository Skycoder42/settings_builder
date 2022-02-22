import 'package:test/test.dart';

import '../models/base/simple_default.dart';
import '../models/group/simple_default.dart';
import '../test_helpers.dart';

void main() {
  group('SimpleDefaultGroup', () {
    testRoot<SimpleDefault>(
      'root',
      createSut: SimpleDefault.new,
      sutClear: (sut) => sut.clear(),
      sutReload: (sut) => sut.reload(),
    );

    testSettingsEntry<SimpleDefault, bool, bool>(
      'simple.boolValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.boolValueKey,
      sutHasValue: (sut) => sut.simple.hasBoolValue,
      sutValue: (sut) => sut.simple.boolValue,
      sutSetValue: (sut, v) => sut.simple.setBoolValue(v),
      sutRemoveValue: (sut) => sut.simple.removeBoolValue(),
      testValue: false,
      defaultValue: true,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: false,
    );

    testSettingsEntry<SimpleDefault, int, int>(
      'simple.intValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.intValueKey,
      sutHasValue: (sut) => sut.simple.hasIntValue,
      sutValue: (sut) => sut.simple.intValue,
      sutSetValue: (sut, v) => sut.simple.setIntValue(v),
      sutRemoveValue: (sut) => sut.simple.removeIntValue(),
      testValue: 0,
      defaultValue: 1,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 0,
    );

    testSettingsEntry<SimpleDefault, double, double>(
      'simple.doubleValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.doubleValueKey,
      sutHasValue: (sut) => sut.simple.hasDoubleValue,
      sutValue: (sut) => sut.simple.doubleValue,
      sutSetValue: (sut, v) => sut.simple.setDoubleValue(v),
      sutRemoveValue: (sut) => sut.simple.removeDoubleValue(),
      testValue: 0.0,
      defaultValue: 0.1,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 0.0,
    );

    testSettingsEntry<SimpleDefault, num, double>(
      'simple.numValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.numValueKey,
      sutHasValue: (sut) => sut.simple.hasNumValue,
      sutValue: (sut) => sut.simple.numValue,
      sutSetValue: (sut, v) => sut.simple.setNumValue(v),
      sutRemoveValue: (sut) => sut.simple.removeNumValue(),
      testValue: 0,
      defaultValue: 2,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 0.0,
    );

    testSettingsEntry<SimpleDefault, String, String>(
      'simple.stringValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.stringValueKey,
      sutHasValue: (sut) => sut.simple.hasStringValue,
      sutValue: (sut) => sut.simple.stringValue,
      sutSetValue: (sut, v) => sut.simple.setStringValue(v),
      sutRemoveValue: (sut) => sut.simple.removeStringValue(),
      testValue: '',
      defaultValue: 'default',
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: '',
    );

    testSettingsEntry<SimpleDefault, List<String>, List<String>>(
      'simple.stringListValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.stringListValueKey,
      sutHasValue: (sut) => sut.simple.hasStringListValue,
      sutValue: (sut) => sut.simple.stringListValue,
      sutSetValue: (sut, v) => sut.simple.setStringListValue(v),
      sutRemoveValue: (sut) => sut.simple.removeStringListValue(),
      testValue: const [],
      defaultValue: const ['a', 'b'],
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const [],
    );

    testSettingsEntry<SimpleDefault, SimpleDefaultEnum, String>(
      'simple.enumValue',
      createSut: SimpleDefault.new,
      sutValueKey: (sut) => sut.simple.enumValueKey,
      sutHasValue: (sut) => sut.simple.hasEnumValue,
      sutValue: (sut) => sut.simple.enumValue,
      sutSetValue: (sut, v) => sut.simple.setEnumValue(v),
      sutRemoveValue: (sut) => sut.simple.removeEnumValue(),
      testValue: SimpleDefaultEnum.value1,
      defaultValue: SimpleDefaultEnum.value3,
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: SimpleDefaultEnum.value1.name,
    );
  });
}
