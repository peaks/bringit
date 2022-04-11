import 'package:git/git.dart';
import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';

abstract class GitProxy {
  Future<bool> isGitDir(String path);

  Future<List<StatusFile>> gitStatus(String path);
}

class GitProxyImplementation implements GitProxy {
  GitProxyImplementation(this.statusCommand);

  final GitStatusCommand statusCommand;

  @override
  Future<bool> isGitDir(String path) async {
    return await GitDir.isGitDir(path);
  }

  @override
  Future<List<StatusFile>> gitStatus(String path) async {
    return statusCommand.run(path);
  }
}
