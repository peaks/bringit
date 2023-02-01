import '../../data/git/git_commit.dart';

class CommitParser {
  GitCommit? map(List<String> consoleCommit) {
    if (consoleCommit.length < 3) {
      return null;
    }
    const String commitBody = 'body parsing not implemented';
    final String commitSubject = consoleCommit[1];
    const String commitEmail = 'not@yet.implemented';
    final List<String> hashTimeStampAuthor =
        _splitOnAntiSlash(consoleCommit[0]);

    return GitCommit(
        _getCommitHash(hashTimeStampAuthor),
        _buildDateFromTimeStamp(hashTimeStampAuthor),
        _getCommitAuthor(hashTimeStampAuthor),
        commitEmail,
        commitSubject,
        commitBody,
        _getReferences(consoleCommit));
  }

  String _getCommitHash(List<String> hashTimeStampAuthor) =>
      hashTimeStampAuthor.first;

  String _getCommitAuthor(List<String> hashTimeStampAuthor) =>
      hashTimeStampAuthor[2];

  List<String> _splitOnAntiSlash(String firstLine) => firstLine.split(r'\');

  DateTime _buildDateFromTimeStamp(List<String> firstLine) {
    return DateTime.fromMillisecondsSinceEpoch(
        _extractTimeStampInMilliSecond(firstLine));
  }

  int _extractTimeStampInMilliSecond(List<String> firstLine) =>
      int.parse(firstLine[1]) * 1000;

  List<String> _getReferences(List<String> commitLines) {
    if (_commitHasReferences(commitLines)) {
      return _splitOnCommaAfterRemovingHead(_getCommitAuthor(commitLines))
          .toList();
    }

    return <String>[];
  }

  Iterable<String> _splitOnCommaAfterRemovingHead(String references) {
    return references
        .replaceAll('HEAD ->', '')
        .split(',')
        .map((String ref) => ref.trim());
  }

  bool _commitHasReferences(Iterable<String> commitLines) =>
      commitLines.elementAt(2).trim().isNotEmpty;
}
