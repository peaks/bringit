import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/data/git_proxy.dart';

class GitProxyMock extends GitProxy {
  bool willFindGitDir = true;
  String _path = '/original/path';

  @override
  Future<bool> isGitDir(String path) async {
    return willFindGitDir;
  }

  @override
  Future<List<StatusFile>> gitStatus(String path) async {
    return <StatusFile>[];
  }

  @override
  Future<String> gitVersion() {
    throw UnimplementedError();
  }

  @override
  String get path => _path;

  @override
  set path(String newPath) {
    _path = newPath;
    notifyListeners();
  }
}
