import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

import '../models/base/mapped_default_base.dart';
import '../models/root/mapped_default.dart';
import '../test_helpers.dart';

void main() {
  group('MappedDefault', () {
    testRoot<MappedDefault>(
      'root',
      createSut: MappedDefault.new,
      sutClear: (sut) => sut.clear(),
      sutReload: (sut) => sut.reload(),
    );

    testSettingsEntry<MappedDefault, MappedDefaultSwitch, bool>(
      'switchValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.switchValueKey,
      sutHasValue: (sut) => sut.hasSwitchValue,
      sutValue: (sut) => sut.switchValue,
      sutSetValue: (sut, v) => sut.setSwitchValue(v),
      sutRemoveValue: (sut) => sut.removeSwitchValue(),
      testValue: MappedDefaultSwitch.on,
      defaultValue: MappedDefaultSwitch.off,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<MappedDefault, MappedDefaultEnum, int>(
      'mappendEnumValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.mappendEnumValueKey,
      sutHasValue: (sut) => sut.hasMappendEnumValue,
      sutValue: (sut) => sut.mappendEnumValue,
      sutSetValue: (sut, v) => sut.setMappendEnumValue(v),
      sutRemoveValue: (sut) => sut.removeMappendEnumValue(),
      testValue: MappedDefaultEnum.value2,
      defaultValue: MappedDefaultEnum.value1,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 1,
    );

    testSettingsEntry<MappedDefault, Tuple2<int, int>, double>(
      'decimalValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.decimalValueKey,
      sutHasValue: (sut) => sut.hasDecimalValue,
      sutValue: (sut) => sut.decimalValue,
      sutSetValue: (sut, v) => sut.setDecimalValue(v),
      sutRemoveValue: (sut) => sut.removeDecimalValue(),
      testValue: const Tuple2(123, 45),
      defaultValue: const Tuple2(0, 0),
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 123.45,
    );

    testSettingsEntry<MappedDefault, Uri, String>(
      'uriValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.uriValueKey,
      sutHasValue: (sut) => sut.hasUriValue,
      sutValue: (sut) => sut.uriValue,
      sutSetValue: (sut, v) => sut.setUriValue(v),
      sutRemoveValue: (sut) => sut.removeUriValue(),
      testValue:
          Uri.https('example.com', '/test/page.html', const <String, String>{
        'a': '1',
        'b': '2',
      }),
      defaultValue: Uri.http('localhost', '/'),
      mockSpGet: (mock) => mock.getString,
      mockSpSet: (mock) => mock.setString,
      mockSpValue: 'https://example.com/test/page.html?a=1&b=2',
    );

    testSettingsEntry<MappedDefault, String, List<String>>(
      'wordsValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.wordsValueKey,
      sutHasValue: (sut) => sut.hasWordsValue,
      sutValue: (sut) => sut.wordsValue,
      sutSetValue: (sut, v) => sut.setWordsValue(v),
      sutRemoveValue: (sut) => sut.removeWordsValue(),
      testValue: 'this is a sentence',
      defaultValue: '',
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const ['this', 'is', 'a', 'sentence'],
    );
  });
}
