import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/git/parsers/commit_parser.dart';
import 'package:test/test.dart';

import '../utils/git_log_commit_formatter.dart';

final CommitParser parser = CommitParser();
late GitLogCommitFormatter formatter;

void main() {
  test('insufficient data returns null', () {
    expect(parser.map(<String>[]), null);
  });

  group('Mapping valid commit property', () {
    setUp(() {
      formatter = GitLogCommitFormatter();
    });

    GitCommit? mapCommit() => parser.map(formatter.format());

    test('it generates a GitCommit', () {
      expect(mapCommit(), isA<GitCommit>());
    });

    test('hash value is mapped to GitCommit.hashValue', () {
      formatter.hash = '1481da5';
      expect(mapCommit()!.hashValue, formatter.hash);
    });

    test('commit Timestamp is mapped into a DateTime', () {
      const String sevenOfJune2022Timestamp = '1654609197';
      formatter.timeStamp = sevenOfJune2022Timestamp;
      expect(
          mapCommit()!.date,
          DateTime.fromMillisecondsSinceEpoch(
              int.parse(sevenOfJune2022Timestamp) * 1000));
    });

    test('author is mapped to GitCommit.author property', () {
      formatter.author = 'John Doe';
      expect(mapCommit()!.author, formatter.author);
    });

    test('subject is mapped to GitCommit.subject property', () {
      formatter.subject = 'fix: fixes the big bad bug';
      expect(mapCommit()!.subject, formatter.subject);
    });

    test('No references means an empty List in GitCommit.references', () {
      expect(mapCommit()!.references.isEmpty, true);
    });

    test('Simple reference is mapped to GitCommit.references', () {
      formatter.reference = 'master';
      expect(mapCommit()!.references, <String>['master']);
    });

    test('"HEAD ->" prefix is ignored from references', () {
      formatter.reference = 'HEAD -> master';
      expect(mapCommit()!.references, <String>['master']);
    });

    test('multiples references are split', () {
      formatter.reference = 'HEAD -> master, my-new-feat';
      expect(mapCommit()!.references, <String>['master', 'my-new-feat']);
    });
  });
}
