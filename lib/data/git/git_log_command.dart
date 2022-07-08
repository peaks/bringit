import 'git_commit.dart';

abstract class GitLogCommand {
  Future<List<GitCommit>> run(String path);
}
