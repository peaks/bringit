import 'package:args/args.dart';

import 'package:git/git.dart';
import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/git/git_registry.dart';

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

Future<void> main(List<String> arguments) async {
  final GitRegistry registry = GitRegistry();
  final GitProxyImplementation git =
      GitProxyImplementation(registry.gitStatusCommand);
  final String path = getPathFromArguments(arguments);
  final bool gitDir = await git.isGitDir(path);

  print('"$path" is ${gitDir ? '' : 'not '}a git directory');
}

String getPathFromArguments(List<String> arguments) {
  final ArgParser parser = ArgParser();
  parser.addOption('path');
  final ArgResults results = parser.parse(arguments);
  final dynamic path = results['path'] ?? '';

  return path as String;
}
