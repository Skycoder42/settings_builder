// ignore_for_file: discarded_futures

import 'package:test/test.dart';

import '../models/group/keys.dart';
import '../test_helpers.dart';

void main() {
  group('KeysGroup', () {
    testRoot<Keys>(
      'root',
      createSut: Keys.new,
      sutClear: (sut) => sut.clear(),
      sutReload: (sut) => sut.reload(),
    );

    testSettingsEntry<Keys, int, int>(
      'keys.simple-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.keys.value1Key,
      sutHasValue: (sut) => sut.keys.hasValue1,
      sutValue: (sut) => sut.keys.value1,
      sutSetValue: (sut, v) => sut.keys.setValue1(v),
      sutRemoveValue: (sut) => sut.keys.removeValue1(),
      testValue: 1,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 1,
    );

    testSettingsEntry<Keys, int, int>(
      'keys.default-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.keys.value2Key,
      sutHasValue: (sut) => sut.keys.hasValue2,
      sutValue: (sut) => sut.keys.value2,
      sutSetValue: (sut, v) => sut.keys.setValue2(v),
      sutRemoveValue: (sut) => sut.keys.removeValue2(),
      testValue: 2,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 2,
    );

    testSettingsEntry<Keys, int, int>(
      'keys.mapped-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.keys.value3Key,
      sutHasValue: (sut) => sut.keys.hasValue3,
      sutValue: (sut) => sut.keys.value3,
      sutSetValue: (sut, v) => sut.keys.setValue3(v),
      sutRemoveValue: (sut) => sut.keys.removeValue3(),
      testValue: 3,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 6,
    );

    testSettingsEntry<Keys, int, int>(
      'keys.default-mapped-value',
      createSut: Keys.new,
      sutValueKey: (sut) => sut.keys.value4Key,
      sutHasValue: (sut) => sut.keys.hasValue4,
      sutValue: (sut) => sut.keys.value4,
      sutSetValue: (sut, v) => sut.keys.setValue4(v),
      sutRemoveValue: (sut) => sut.keys.removeValue4(),
      testValue: 4,
      defaultValue: 0,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 8,
    );
  });
}
