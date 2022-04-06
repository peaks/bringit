import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/data/git_proxy.dart';

class GitProxyMock implements GitProxy {
  bool willFindGitDir = true;

  @override
  Future<bool> isGitDir(String path) async {
    return willFindGitDir;
  }

  @override
  Future<List<StatusFile>> gitStatus(String path) async {
    return <StatusFile>[];
  }
}