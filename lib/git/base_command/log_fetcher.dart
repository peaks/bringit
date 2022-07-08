import 'dart:convert';

import 'package:git_ihm/git/base_command/terminal_command.dart';

class LogFetcher {
  Future<List<String>> fetch(String workingDirectory) async {
    return LineSplitter.split(await _callGitLog(workingDirectory)).toList();
  }

  Future<String> _callGitLog(String workingDirectory) async {
    final TerminalCommand command =
        TerminalCommand('git', <String>['log', r'--format=%h\%ct\%cn%n%s%n%D']);

    return await command.run(workingDirectory);
  }
}
