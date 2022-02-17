import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

extension _StringX on String {
  String get pascal {
    if (this.isEmpty) {
      return '';
    }

    return this[0].toUpperCase() + substring(1);
  }
}

@isTestGroup
void testSettingsEntry<TValue extends Object, TSettings extends Object>(
  String key, {
  required SharedPreferences mockSp,
  required String Function() sutValueKey,
  required bool Function() sutHasValue,
  required TValue? Function() sutValue,
  required Future<bool> Function(TValue) sutSetValue,
  required Future<bool> Function() sutRemoveValue,
  required TValue testValue,
  required TSettings? Function(String) mockSpGet,
  required Future<bool> Function(String, TSettings) mockSpSet,
  required TSettings mockSpValue,
  TValue? defaultValue,
}) =>
    group(key, () {
      assert(mockSp is Mock);

      test('${key}Key returns correct key', () {
        expect(sutValueKey(), key);
      });

      test('has${key.pascal} returns preferences containsKey', () {
        when(() => mockSp.containsKey(any())).thenReturn(true);

        expect(sutHasValue(), isTrue);

        verify(() => mockSp.containsKey(key));
      });

      group(key, () {
        test('returns $defaultValue by default', () {
          expect(sutValue(), defaultValue);
        });

        test('returns preferences value', () {
          when(() => mockSpGet(any())).thenReturn(mockSpValue);

          expect(sutValue(), testValue);

          verify(() => mockSpGet(key));
        });
      });

      test('set${key.pascal} sets value in shared preferences', () async {
        when(() => mockSpSet(any(), any())).thenAnswer((i) async => true);

        await expectLater(sutSetValue(testValue), completion(isTrue));

        verify(() => mockSpSet(key, mockSpValue));
      });

      test('remove${key.pascal} removes entry from shared preferences',
          () async {
        when(() => mockSp.remove(any())).thenAnswer((i) async => true);

        await expectLater(sutRemoveValue(), completion(isTrue));

        verify(() => mockSp.remove(key));
      });
    });
