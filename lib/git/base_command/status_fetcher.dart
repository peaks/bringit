import 'dart:convert';
import 'dart:io';

import 'package:git/git.dart';

class StatusFetcher {
  Future<List<String>> fetch(String path) async {
    final GitDir git = await GitDir.fromExisting(path);
    final String results = await _callGitStatus(git);
    const LineSplitter splitter = LineSplitter();

    return splitter.convert(results);
  }

  Future<String> _callGitStatus(GitDir git) async {
    final ProcessResult result =
        await git.runCommand(
            <String>['status', '--porcelain=v1', '--ignored=matching']);

    return _extractStringStdOutOrEmpty(result);
  }

  String _extractStringStdOutOrEmpty(ProcessResult result) {
    final dynamic standardOutput = result.stdout;

    return (standardOutput is String) ? standardOutput : '';
  }
}
