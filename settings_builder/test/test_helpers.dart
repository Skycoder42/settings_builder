import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'models/test_shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

extension _StringX on String {
  String get pascal {
    if (this.isEmpty) {
      return '';
    }

    return this[0].toUpperCase() + substring(1);
  }
}

@isTest
void testClear<TSettings extends Object>(
  String description, {
  required TSettings Function(SharedPreferences) createSut,
  required Future<bool> Function(TSettings) sutClear,
}) =>
    test(description, () async {
      final mockSp = MockSharedPreferences();
      final sut = createSut(mockSp);

      when(() => mockSp.clear()).thenAnswer((i) async => true);

      await expectLater(sutClear(sut), completion(isTrue));

      verify(() => mockSp.clear());
    });

@isTestGroup
void testSettingsEntry<TSettings extends Object, TValue extends Object,
        TData extends Object>(
  String description, {
  required TSettings Function(SharedPreferences, [String?]) createSut,
  required String Function(TSettings) sutValueKey,
  required bool Function(TSettings) sutHasValue,
  required TValue? Function(TSettings) sutValue,
  required Future<bool> Function(TSettings, TValue) sutSetValue,
  required Future<bool> Function(TSettings) sutRemoveValue,
  required TValue testValue,
  required TData? Function(String) Function(SharedPreferences) mockSpGet,
  required Future<bool> Function(String, TData) Function(SharedPreferences)
      mockSpSet,
  required TData mockSpValue,
  TValue? defaultValue,
}) =>
    group(description, () {
      for (final prefix in [null, 'test-prefix.data']) {
        group(prefix == null ? '(no prefix)' : '(prefix: $prefix)', () {
          final mockSp = MockSharedPreferences();

          late TSettings sut;

          final key = prefix == null ? description : '$prefix.$description';

          setUp(() {
            reset(mockSp);

            sut = createSut(mockSp, prefix);
          });

          test('${description}Key returns correct key', () {
            expect(sutValueKey(sut), key);
          });

          test('has${description.pascal} returns preferences containsKey', () {
            when(() => mockSp.containsKey(any())).thenReturn(true);

            expect(sutHasValue(sut), isTrue);

            verify(() => mockSp.containsKey(key));
          });

          group(description, () {
            test('returns $defaultValue by default', () {
              expect(sutValue(sut), defaultValue);
            });

            test('returns $testValue from preferences with value $mockSpValue',
                () {
              when(() => mockSpGet(mockSp)(any())).thenReturn(mockSpValue);

              expect(sutValue(sut), testValue);

              verify(() => mockSpGet(mockSp)(key));
            });
          });

          test(
              'set${description.pascal}($testValue) sets value in shared preferences to $mockSpValue',
              () async {
            when(() => mockSpSet(mockSp)(any(), any()))
                .thenAnswer((i) async => true);

            await expectLater(sutSetValue(sut, testValue), completion(isTrue));

            verify(() => mockSpSet(mockSp)(key, mockSpValue));
          });

          test(
              'remove${description.pascal} removes entry from shared preferences',
              () async {
            when(() => mockSp.remove(any())).thenAnswer((i) async => true);

            await expectLater(sutRemoveValue(sut), completion(isTrue));

            verify(() => mockSp.remove(key));
          });
        });
      }
    });
