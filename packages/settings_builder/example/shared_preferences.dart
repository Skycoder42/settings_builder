// A Dummy implementation for the SharedPreferences
class SharedPreferences {
  final values = <String, Object>{};

  static Future<SharedPreferences> getInstance() =>
      Future.value(SharedPreferences());

  Future<bool> clear() async {
    values.clear();
    return true;
  }

  bool containsKey(String key) => values.containsKey(key);

  bool? getBool(String key) => values[key] as bool?;

  double? getDouble(String key) => values[key] as double?;

  int? getInt(String key) => values[key] as int?;

  String? getString(String key) => values[key] as String?;

  List<String>? getStringList(String key) => values[key] as List<String>?;

  Future<bool> remove(String key) async {
    values.remove(key);
    return true;
  }

  // ignore: avoid_positional_boolean_parameters
  Future<bool> setBool(String key, bool value) async {
    values[key] = value;
    return true;
  }

  Future<bool> setDouble(String key, double value) async {
    values[key] = value;
    return true;
  }

  Future<bool> setInt(String key, int value) async {
    values[key] = value;
    return true;
  }

  Future<bool> setString(String key, String value) async {
    values[key] = value;
    return true;
  }

  Future<bool> setStringList(String key, List<String> value) async {
    values[key] = value;
    return true;
  }
}
