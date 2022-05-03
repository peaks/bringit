import 'package:git/git.dart';
import 'package:git_ihm/data/git/status_file.dart';

import '../git/git_registry.dart';

abstract class GitProxy {
  Future<bool> isGitDir(String path);

  Future<List<StatusFile>> gitStatus(String path);

  Future<String> gitVersion();
}

class GitProxyImplementation implements GitProxy {
  GitProxyImplementation(this.registry);

  final GitRegistry registry;

  @override
  Future<bool> isGitDir(String path) async {
    return await GitDir.isGitDir(path);
  }

  @override
  Future<List<StatusFile>> gitStatus(String path) async {
    return registry.statusCommand.run(path);
  }

  @override
  Future<String> gitVersion() async {
    return registry.versionCommand.run();
  }
}
