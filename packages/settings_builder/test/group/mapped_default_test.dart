// ignore_for_file: discarded_futures

import 'package:test/test.dart';

import '../models/base/mapped_default_base.dart';
import '../models/group/mapped_default.dart';
import '../test_helpers.dart';

void main() {
  group('MappedDefaultGroup', () {
    testRoot<MappedDefault>(
      'root',
      createSut: MappedDefault.new,
      sutClear: (sut) => sut.clear(),
      sutReload: (sut) => sut.reload(),
    );

    testSettingsEntry<MappedDefault, MappedDefaultSwitch, bool>(
      'mapped.switchValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.mapped.switchValueKey,
      sutHasValue: (sut) => sut.mapped.hasSwitchValue,
      sutValue: (sut) => sut.mapped.switchValue,
      sutSetValue: (sut, v) => sut.mapped.setSwitchValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeSwitchValue(),
      testValue: MappedDefaultSwitch.on,
      defaultValue: MappedDefaultSwitch.off,
      mockSpGet: (mock) => mock.getBool,
      mockSpSet: (mock) => mock.setBool,
      mockSpValue: true,
    );

    testSettingsEntry<MappedDefault, MappedDefaultEnum, int>(
      'mapped.mappendEnumValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.mapped.mappendEnumValueKey,
      sutHasValue: (sut) => sut.mapped.hasMappendEnumValue,
      sutValue: (sut) => sut.mapped.mappendEnumValue,
      sutSetValue: (sut, v) => sut.mapped.setMappendEnumValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeMappendEnumValue(),
      testValue: MappedDefaultEnum.value2,
      defaultValue: MappedDefaultEnum.value1,
      mockSpGet: (mock) => mock.getInt,
      mockSpSet: (mock) => mock.setInt,
      mockSpValue: 1,
    );

    testSettingsEntry<MappedDefault, (int, int), double>(
      'mapped.decimalValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.mapped.decimalValueKey,
      sutHasValue: (sut) => sut.mapped.hasDecimalValue,
      sutValue: (sut) => sut.mapped.decimalValue,
      sutSetValue: (sut, v) => sut.mapped.setDecimalValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeDecimalValue(),
      testValue: const (123, 45),
      defaultValue: const (0, 0),
      mockSpGet: (mock) => mock.getDouble,
      mockSpSet: (mock) => mock.setDouble,
      mockSpValue: 123.45,
    );

    testSettingsEntry<MappedDefault, Uri, String>(
      'mapped.uriValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.mapped.uriValueKey,
      sutHasValue: (sut) => sut.mapped.hasUriValue,
      sutValue: (sut) => sut.mapped.uriValue,
      sutSetValue: (sut, v) => sut.mapped.setUriValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeUriValue(),
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
      'mapped.wordsValue',
      createSut: MappedDefault.new,
      sutValueKey: (sut) => sut.mapped.wordsValueKey,
      sutHasValue: (sut) => sut.mapped.hasWordsValue,
      sutValue: (sut) => sut.mapped.wordsValue,
      sutSetValue: (sut, v) => sut.mapped.setWordsValue(v),
      sutRemoveValue: (sut) => sut.mapped.removeWordsValue(),
      testValue: 'this is a sentence',
      defaultValue: '',
      mockSpGet: (mock) => mock.getStringList,
      mockSpSet: (mock) => mock.setStringList,
      mockSpValue: const ['this', 'is', 'a', 'sentence'],
    );
  });
}
