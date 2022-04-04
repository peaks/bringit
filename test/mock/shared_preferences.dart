import 'package:shared_preferences/shared_preferences.dart';

class MockedSharedPreferences implements SharedPreferences {
  Map<String, String> storedString = <String, String>{};

  @override
  Future<bool> setString(String id, String value) async {
    storedString[id] = value;

    return true;
  }

  @override
  String? getString(String id) {
    return storedString[id];
  }

  @override
  Future<bool> clear() {
    throw UnimplementedError();
  }

  @override
  Future<bool> commit() {
    throw UnimplementedError();
  }

  @override
  bool containsKey(String key) {
    throw UnimplementedError();
  }

  @override
  Object? get(String key) {
    throw UnimplementedError();
  }

  @override
  bool? getBool(String key) {
    throw UnimplementedError();
  }

  @override
  double? getDouble(String key) {
    throw UnimplementedError();
  }

  @override
  int? getInt(String key) {
    throw UnimplementedError();
  }

  @override
  Set<String> getKeys() {
    throw UnimplementedError();
  }

  @override
  List<String>? getStringList(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> reload() {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setBool(String key, bool value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setDouble(String key, double value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setInt(String key, int value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    throw UnimplementedError();
  }
}
