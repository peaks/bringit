import 'package:git_ihm/data/path_manager.dart';

class PathManagerMock implements PathManager {
  PathManagerMock(this._currentPath);

  String _currentPath = '';

  @override
  String get path => _currentPath;

  @override
  set path(String path) => _currentPath = path;
}
