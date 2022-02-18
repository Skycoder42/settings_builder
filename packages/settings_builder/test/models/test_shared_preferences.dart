abstract class SharedPreferences {
  static Future<SharedPreferences> getInstance() => throw UnimplementedError();

  Future<bool> clear();

  bool containsKey(String key);

  bool? getBool(String key);

  double? getDouble(String key);

  int? getInt(String key);

  String? getString(String key);

  List<String>? getStringList(String key);

  Future<bool> remove(String key);

  // ignore: avoid_positional_boolean_parameters
  Future<bool> setBool(String key, bool value);

  Future<bool> setDouble(String key, double value);

  Future<bool> setInt(String key, int value);

  Future<bool> setString(String key, String value);

  Future<bool> setStringList(String key, List<String> value);
}
