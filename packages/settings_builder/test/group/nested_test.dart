import 'package:test/test.dart';

import '../models/group/nested.dart';
import '../test_helpers.dart';

void main() {
  group('Nested', () {
    testClear<Nested>(
      'clear calls clear on shared preferences',
      createSut: Nested.new,
      sutClear: (sut) => sut.clear(),
    );

    testSettingsEntry<Nested, int, int>(
      'group1.value1',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group1.value1Key,
      sutHasValue: (sut) => sut.group1.hasValue1,
      sutValue: (sut) => sut.group1.value1,
      sutSetValue: (sut, v) => sut.group1.setValue1(v),
      sutRemoveValue: (sut) => sut.group1.removeValue1(),
      testValue: 11,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 11,
    );

    testSettingsEntry<Nested, int, int>(
      'group2.group1.value1',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group2.group1.value1Key,
      sutHasValue: (sut) => sut.group2.group1.hasValue1,
      sutValue: (sut) => sut.group2.group1.value1,
      sutSetValue: (sut, v) => sut.group2.group1.setValue1(v),
      sutRemoveValue: (sut) => sut.group2.group1.removeValue1(),
      testValue: 211,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 211,
    );

    testSettingsEntry<Nested, int, int>(
      'group2.value2',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group2.value2Key,
      sutHasValue: (sut) => sut.group2.hasValue2,
      sutValue: (sut) => sut.group2.value2,
      sutSetValue: (sut, v) => sut.group2.setValue2(v),
      sutRemoveValue: (sut) => sut.group2.removeValue2(),
      testValue: 22,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 22,
    );

    testSettingsEntry<Nested, int, int>(
      'group3.group1.value1',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group3.group1.value1Key,
      sutHasValue: (sut) => sut.group3.group1.hasValue1,
      sutValue: (sut) => sut.group3.group1.value1,
      sutSetValue: (sut, v) => sut.group3.group1.setValue1(v),
      sutRemoveValue: (sut) => sut.group3.group1.removeValue1(),
      testValue: 311,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 311,
    );

    testSettingsEntry<Nested, int, int>(
      'group3.group2.group1.value1',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group3.group2.group1.value1Key,
      sutHasValue: (sut) => sut.group3.group2.group1.hasValue1,
      sutValue: (sut) => sut.group3.group2.group1.value1,
      sutSetValue: (sut, v) => sut.group3.group2.group1.setValue1(v),
      sutRemoveValue: (sut) => sut.group3.group2.group1.removeValue1(),
      testValue: 3211,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 3211,
    );

    testSettingsEntry<Nested, int, int>(
      'group3.group2.value2',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group3.group2.value2Key,
      sutHasValue: (sut) => sut.group3.group2.hasValue2,
      sutValue: (sut) => sut.group3.group2.value2,
      sutSetValue: (sut, v) => sut.group3.group2.setValue2(v),
      sutRemoveValue: (sut) => sut.group3.group2.removeValue2(),
      testValue: 322,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 322,
    );

    testSettingsEntry<Nested, int, double>(
      'group3.value3',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.group3.value3Key,
      sutHasValue: (sut) => sut.group3.hasValue3,
      sutValue: (sut) => sut.group3.value3,
      sutSetValue: (sut, v) => sut.group3.setValue3(v),
      sutRemoveValue: (sut) => sut.group3.removeValue3(),
      testValue: 33,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 33.0,
    );

    testSettingsEntry<Nested, int, double>(
      'value4',
      createSut: Nested.new,
      sutValueKey: (sut) => sut.value4Key,
      sutHasValue: (sut) => sut.hasValue4,
      sutValue: (sut) => sut.value4,
      sutSetValue: (sut, v) => sut.setValue4(v),
      sutRemoveValue: (sut) => sut.removeValue4(),
      testValue: 4,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 4.0,
    );
  });
}
