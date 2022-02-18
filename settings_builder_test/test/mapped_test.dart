import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

import 'models/mapped.dart';
import 'test_helpers.dart';

void main() {
  group('Mapped', () {
    testSettingsEntry<Mapped, MappedSwitch, bool>(
      'switchValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.switchValueKey,
      sutHasValue: (sut) => sut.hasSwitchValue,
      sutValue: (sut) => sut.switchValue,
      sutSetValue: (sut, v) => sut.setSwitchValue(v),
      sutRemoveValue: (sut) => sut.removeSwitchValue(),
      testValue: MappedSwitch.on,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<Mapped, MappedEnum, int>(
      'mappendEnumValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.mappendEnumValueKey,
      sutHasValue: (sut) => sut.hasMappendEnumValue,
      sutValue: (sut) => sut.mappendEnumValue,
      sutSetValue: (sut, v) => sut.setMappendEnumValue(v),
      sutRemoveValue: (sut) => sut.removeMappendEnumValue(),
      testValue: MappedEnum.value3,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 2,
    );

    testSettingsEntry<Mapped, Tuple2<int, int>, double>(
      'decimalValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.decimalValueKey,
      sutHasValue: (sut) => sut.hasDecimalValue,
      sutValue: (sut) => sut.decimalValue,
      sutSetValue: (sut, v) => sut.setDecimalValue(v),
      sutRemoveValue: (sut) => sut.removeDecimalValue(),
      testValue: Tuple2(123, 45),
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 123.45,
    );

    testSettingsEntry<Mapped, Uri, String>(
      'uriValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.uriValueKey,
      sutHasValue: (sut) => sut.hasUriValue,
      sutValue: (sut) => sut.uriValue,
      sutSetValue: (sut, v) => sut.setUriValue(v),
      sutRemoveValue: (sut) => sut.removeUriValue(),
      testValue: Uri.https('example.com', '/test/page.html', const {
        'a': '1',
        'b': '2',
      }),
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: 'https://example.com/test/page.html?a=1&b=2',
    );

    testSettingsEntry<Mapped, String, List<String>>(
      'wordsValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.wordsValueKey,
      sutHasValue: (sut) => sut.hasWordsValue,
      sutValue: (sut) => sut.wordsValue,
      sutSetValue: (sut, v) => sut.setWordsValue(v),
      sutRemoveValue: (sut) => sut.removeWordsValue(),
      testValue: 'this is a sentence',
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const ['this', 'is', 'a', 'sentence'],
    );
  });
}
