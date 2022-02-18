import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

import '../models/base/mapped_base.dart';
import '../models/group/mapped.dart';
import '../test_helpers.dart';

void main() {
  group('MappedGroup', () {
    testClear<Mapped>(
      'clear calls clear on shared preferences',
      createSut: Mapped.new,
      sutClear: (sut) => sut.clear(),
    );

    testSettingsEntry<Mapped, MappedSwitch, bool>(
      'mapped.switchValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.mapped.switchValueKey,
      sutHasValue: (sut) => sut.mapped.hasSwitchValue,
      sutValue: (sut) => sut.mapped.switchValue,
      sutSetValue: (sut, v) => sut.mapped.setSwitchValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeSwitchValue(),
      testValue: MappedSwitch.on,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<Mapped, MappedEnum, int>(
      'mapped.mappendEnumValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.mapped.mappendEnumValueKey,
      sutHasValue: (sut) => sut.mapped.hasMappendEnumValue,
      sutValue: (sut) => sut.mapped.mappendEnumValue,
      sutSetValue: (sut, v) => sut.mapped.setMappendEnumValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeMappendEnumValue(),
      testValue: MappedEnum.value3,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 2,
    );

    testSettingsEntry<Mapped, Tuple2<int, int>, double>(
      'mapped.decimalValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.mapped.decimalValueKey,
      sutHasValue: (sut) => sut.mapped.hasDecimalValue,
      sutValue: (sut) => sut.mapped.decimalValue,
      sutSetValue: (sut, v) => sut.mapped.setDecimalValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeDecimalValue(),
      testValue: Tuple2(123, 45),
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 123.45,
    );

    testSettingsEntry<Mapped, Uri, String>(
      'mapped.uriValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.mapped.uriValueKey,
      sutHasValue: (sut) => sut.mapped.hasUriValue,
      sutValue: (sut) => sut.mapped.uriValue,
      sutSetValue: (sut, v) => sut.mapped.setUriValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeUriValue(),
      testValue: Uri.https('example.com', '/test/page.html', const {
        'a': '1',
        'b': '2',
      }),
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: 'https://example.com/test/page.html?a=1&b=2',
    );

    testSettingsEntry<Mapped, String, List<String>>(
      'mapped.wordsValue',
      createSut: Mapped.new,
      sutValueKey: (sut) => sut.mapped.wordsValueKey,
      sutHasValue: (sut) => sut.mapped.hasWordsValue,
      sutValue: (sut) => sut.mapped.wordsValue,
      sutSetValue: (sut, v) => sut.mapped.setWordsValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeWordsValue(),
      testValue: 'this is a sentence',
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const ['this', 'is', 'a', 'sentence'],
    );
  });
}
