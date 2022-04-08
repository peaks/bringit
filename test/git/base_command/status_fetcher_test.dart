@Tags(<String>['git-interpreter'])

import 'dart:io';

import 'package:git_ihm/git/base_command/status_fetcher.dart';
import 'package:test/test.dart';

void main() {
  final StatusFetcher fetcher = StatusFetcher();
  const String path = '/tmp/git-ihm/gitProject';
  late List<String> createdFiles;

  Future<File> createEmptyFile(String fileName) async {
    final String fullPath = '$path/$fileName';
    createdFiles.add(fullPath);
    return File(fullPath).writeAsString('');
  }

  setUp(() {
    createdFiles = <String>[];
  });

  test('returns "git status" results as a list of strings', () async {
    const String untrackedFile = 'new_file.txt';
    await createEmptyFile(untrackedFile);

    final List<String> result = await fetcher.fetch(path);
    expect(result.contains('?? $untrackedFile'), equals(true));
  });

  tearDown(() {
    for (final String path in createdFiles) {
      final File createdFile = File(path);
      createdFile.delete();
    }
  });
}
