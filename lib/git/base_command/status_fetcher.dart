import 'dart:convert';
import 'package:git_ihm/git/base_command/terminal_command.dart';

class StatusFetcher {
  static const LineSplitter _splitter = LineSplitter();

  Future<List<String>> fetch(String path) async {
    final String results = await _callGitStatus(path);
    return _splitter.convert(results);
  }

  Future<String> _callGitStatus(String path) async {
    final TerminalCommand command = TerminalCommand(
        'git', <String>['status', '--porcelain=v1', '--ignored=matching']);

    return command.run(path);
  }
}
