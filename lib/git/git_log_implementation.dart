import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/data/git/git_log_command.dart';
import 'package:git_ihm/git/base_command/log_fetcher.dart';
import 'package:git_ihm/git/parsers/commit_parser.dart';

class GitLogImplementation extends GitLogCommand {
  GitLogImplementation(this._fetcher, this._parser);

  final LogFetcher _fetcher;
  final CommitParser _parser;

  @override
  Future<List<GitCommit>> run(String path) async {
    return _mapIntoCommit(await _fetcher.fetch(path));
  }

  Future<List<GitCommit>> _mapIntoCommit(List<String> logLines) async {
    final List<GitCommit> result = <GitCommit>[];

    await for (final List<String> chunk in _parseByGroupOfThree(logLines)) {
      _addToResult(_parser.map(chunk), result);
    }

    return result;
  }

  Stream<List<String>> _parseByGroupOfThree(List<String> logContent) async* {
    final Iterator<String> iterator = logContent.iterator;
    final List<String> chunk = <String>[];

    while (iterator.moveNext()) {
      chunk.add(iterator.current);
      if (chunk.length == 3) {
        yield chunk;
        chunk.clear();
      }
    }
  }

  void _addToResult(GitCommit? commit, List<GitCommit> result) {
    if (commit is GitCommit) {
      result.add(commit);
    }
  }
}
