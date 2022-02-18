abstract class SharedPreferences {
  static Future<SharedPreferences> getInstance() => throw UnimplementedError();

  @override
  Future<bool> clear();

  @override
  bool containsKey(String key);

  @override
  bool? getBool(String key);

  @override
  double? getDouble(String key);

  @override
  int? getInt(String key);

  @override
  String? getString(String key);

  @override
  List<String>? getStringList(String key);

  @override
  Future<bool> remove(String key);

  @override
  Future<bool> setBool(String key, bool value);

  @override
  Future<bool> setDouble(String key, double value);

  @override
  Future<bool> setInt(String key, int value);

  @override
  Future<bool> setString(String key, String value);

  @override
  Future<bool> setStringList(String key, List<String> value);
}
