import 'dart:io';
import 'package:args/args.dart';

import 'package:git/git.dart';

class StatusCommand {
  
  Future<List<String>> run(String path) async {
    final GitDir git = await GitDir.fromExisting(path);
    final String results = await _callGitStatus(git);

    return results.split(gitLineSeparator);
  }

  String get gitLineSeparator => String.fromCharCode(0);

  Future<String> _callGitStatus(GitDir git) async {
    final ProcessResult result =
      await git.runCommand(<String>['status', '--porcelain', '-z']);
    
    return _extractStringStdOutOrEmpty(result);
  }

  String _extractStringStdOutOrEmpty(ProcessResult result) {
    final dynamic standardOutput = result.stdout;

    return (standardOutput is String) ? standardOutput : '';
  }
}

Future<void> main(List<String> arguments) async {
  final StatusCommand command = StatusCommand();
  final String path = getPathFromArguments(arguments);
  final List<String> gitFiles = await command.run(path);

  gitFiles.forEach(print);
}

String getPathFromArguments(List<String> arguments) {
  final ArgParser parser = ArgParser();
  parser.addOption('path');
  final ArgResults results = parser.parse(arguments);
  final dynamic path = results['path'] ?? './';

  return path as String;
}
