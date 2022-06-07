import 'dart:io';

import 'package:git_ihm/utils/file/tree/file_system_loader.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  final FileSystemLoader testSubject = FileSystemLoader();

  test('it throws exception if path is not a directory', () {
    expect(() => testSubject.list(InvalidDirectoryFake()),
        throwsA(isA<FileSystemException>()));
  });

  test('On empty directory it returns an empty list', () {
    expect(
        testSubject.list(EmptyDirectoryFake()), equals(<FileSystemEntity>[]));
  });

  test('it returns the directory content as a FileSystemEntity list', () {
    final List<FileSystemEntity> mockedContent = <FileSystemEntity>[];
    final Directory filledDirectory = PreFilledDirectoryFake(mockedContent);

    expect(testSubject.list(filledDirectory), same(mockedContent));
  });

  test('it sorts entities by names', () {
    final List<FileSystemEntity> mockedContent = <FileSystemEntity>[
      Directory('/bernie'),
      Directory('/albert'),
    ];

    final List<FileSystemEntity> testResult =
        testSubject.list(PreFilledDirectoryFake(mockedContent));

    expect(
        getContentAsPathList(testResult),
        equals(<String>[
          '/albert',
          '/bernie',
        ]));
  });

  test('it sorts directories first', () {
    final List<FileSystemEntity> mockedContent = <FileSystemEntity>[
      File('/foo/bar'),
      Directory('/foo'),
    ];

    final List<FileSystemEntity> testResult =
        testSubject.list(PreFilledDirectoryFake(mockedContent));

    expect(testResult.first, isA<Directory>());
  });
}

List<String> getContentAsPathList(List<FileSystemEntity> testResult) {
  final List<String> pathList = <String>[];
  for (final FileSystemEntity entity in testResult) {
    pathList.add(entity.path);
  }
  return pathList;
}

class InvalidDirectoryFake extends Fake implements Directory {
  @override
  bool existsSync() => false;
}

class EmptyDirectoryFake extends InvalidDirectoryFake {
  @override
  bool existsSync() => true;

  @override
  List<FileSystemEntity> listSync(
      {bool recursive = false, bool followLinks = true}) {
    return <FileSystemEntity>[];
  }
}

class PreFilledDirectoryFake extends EmptyDirectoryFake {
  PreFilledDirectoryFake(this.expectedContent);

  final List<FileSystemEntity> expectedContent;

  @override
  List<FileSystemEntity> listSync(
      {bool recursive = false, bool followLinks = true}) {
    return expectedContent;
  }
}
