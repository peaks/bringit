import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/git/git_status_implementation.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';
import 'package:test/test.dart';

import '../mock/status_fetcher_mock.dart';

void main() {
  late GitStatusImplementation command;
  late StatusFetcherMock mockedCommand;
  const String testPath = '/any/path';

  setUp(() {
    mockedCommand = StatusFetcherMock();
    mockedCommand.willRunFor(testPath);
    command = GitStatusImplementation(StatusParser(), mockedCommand);
  });

  test('create class', () {
    expect(command, isA<GitStatusCommand>());
  });

  test('returns empty list when status command returns empty list', () async {
    expect(await command.run(testPath), isEmpty);
  });

  test('returns untracked file in results', () async {
    const String filePath = 'my/untracked/file/path';
    mockedCommand.pushUntrackedResult(filePath);

    final List<StatusFile> result = await command.run(testPath);

    expect(result.contains(const UntrackedPath(filePath)), isTrue);
  });

  test('returns modified file in results', () async {
    const String filePath = 'my/modified/file/path';
    mockedCommand.pushModifiedResult(filePath);

    final List<StatusFile> result = await command.run(testPath);

    expect(result.contains(const ModifiedFile(filePath)), isTrue);
  });

  test('returns added files in results', () async {
    const String filePath1 = 'my/added/file1/path';
    const String filePath2 = 'my/added/file2/path';
    mockedCommand.pushModifiedOrAddedResult(filePath1);
    mockedCommand.pushUntrackedAndAdded(filePath2);

    final List<StatusFile> result = await command.run(testPath);

    expect(result.contains(const AddedFile(filePath1)), isTrue);
    expect(result.contains(const AddedFile(filePath2)), isTrue);
  });

  test('returns ignored file in results', () async {
    const String filePath = 'my/modified/file/path';
    mockedCommand.pushIgnoredResult(filePath);

    final List<StatusFile> result = await command.run(testPath);

    expect(result.contains(const IgnoredFile(filePath)), isTrue);
  });
}
