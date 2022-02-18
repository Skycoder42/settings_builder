import 'package:test/test.dart';

import '../models/root/keys.dart';
import '../test_helpers.dart';

void main() {
  group('Keys', () {
    testClear<Keys>(
      'clear calls clear on shared preferences',
      createSut: Keys.new,
      sutClear: (sut) => sut.clear(),
    );

    testSettingsEntry<Keys, int, int>(
      'simple-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.value1Key,
      sutHasValue: (sut) => sut.hasValue1,
      sutValue: (sut) => sut.value1,
      sutSetValue: (sut, v) => sut.setValue1(v),
      sutRemoveValue: (sut) => sut.removeValue1(),
      testValue: 1,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 1,
    );

    testSettingsEntry<Keys, int, int>(
      'default-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.value2Key,
      sutHasValue: (sut) => sut.hasValue2,
      sutValue: (sut) => sut.value2,
      sutSetValue: (sut, v) => sut.setValue2(v),
      sutRemoveValue: (sut) => sut.removeValue2(),
      testValue: 2,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 2,
    );

    testSettingsEntry<Keys, int, int>(
      'mapped-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.value3Key,
      sutHasValue: (sut) => sut.hasValue3,
      sutValue: (sut) => sut.value3,
      sutSetValue: (sut, v) => sut.setValue3(v),
      sutRemoveValue: (sut) => sut.removeValue3(),
      testValue: 3,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 6,
    );

    testSettingsEntry<Keys, int, int>(
      'default-mapped-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.value4Key,
      sutHasValue: (sut) => sut.hasValue4,
      sutValue: (sut) => sut.value4,
      sutSetValue: (sut, v) => sut.setValue4(v),
      sutRemoveValue: (sut) => sut.removeValue4(),
      testValue: 4,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 8,
    );
  });
}
