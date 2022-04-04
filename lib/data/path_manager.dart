import 'package:shared_preferences/shared_preferences.dart';

abstract class PathManager {
  String get path;
  set path(String path);
}

class SpPathManager implements PathManager {
  SpPathManager(this._sp);

  final SharedPreferences _sp;
  final String pathKey = 'currentPath';

  @override
  String get path => _sp.getString(pathKey) ?? '';

  @override
  set path(String path) => _setPath(path);

  Future<void> _setPath(String path) async {
    await _sp.setString(pathKey, path);
  }
}
