import 'package:args/args.dart';

import 'package:git/git.dart';

abstract class GitProxy {
  Future<bool> isGitDir(String path);
}

class GitProxyImplementation implements GitProxy {
  @override
  Future<bool> isGitDir(String path) async {
    return await GitDir.isGitDir(path);
  }
}

Future<void> main(List<String> arguments) async {
  final GitProxyImplementation git = GitProxyImplementation();
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
