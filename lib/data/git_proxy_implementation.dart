import 'package:git/git.dart';
import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/data/path_manager.dart';

import '../git/git_registry.dart';
import 'git/status_file.dart';
import 'git_proxy.dart';

class GitProxyImplementation extends GitProxy {
  GitProxyImplementation(this._registry, this._pathManager) {
    getStatus();
  }

  final GitRegistry _registry;
  final PathManager _pathManager;

  @override
  Future<bool> isGitDir(String path) async {
    return await GitDir.isGitDir(path);
  }

  @override
  Future<List<StatusFile>> gitStatus(String path) async {
    return _registry.statusCommand.run(path);
  }

  @override
  Future<String> gitVersion() async {
    return _registry.versionCommand.run();
  }

  @override
  String get path => _pathManager.path;

  @override
  set path(String newPath) {
    _pathManager.path = newPath;
    getStatus();
  }

  @override
  Future<void> getStatus() async {
    gitState = await gitStatus(path);
    notifyListeners();
  }

  @override
  Future<List<GitCommit>> gitLog() async {
    return _registry.logCommand.run(path);
  }
}
