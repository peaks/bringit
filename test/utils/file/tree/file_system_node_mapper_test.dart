import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/utils/file/icons/file_icondata.dart';
import 'package:git_ihm/utils/file/tree/file_system_node_mapper.dart';

late FileSystemNodeMapper mapper;
late IconFetcherSpy fetcher;

void main() {
  setUp(() {
    fetcher = IconFetcherSpy();
    mapper = FileSystemNodeMapper(fetcher);
  });

  test('it maps absolute path to key', () {
    const String absolutePath = '/foo/bar';
    final Node<void> mappedResult = testMappingFile(absolutePath);

    expect(mappedResult.key, equals(absolutePath));
  });

  test('it maps basename to label', () {
    const String baseName = 'bar';
    final Node<void> mappedResult = testMappingFile('/home/$baseName');

    expect(mappedResult.label, equals(baseName));
  });

  test('it maps iconColor to white', () {
    final Node<void> mappedResult = testMappingFile('/any/file');

    expect(mappedResult.iconColor, equals(Colors.white));
  });

  test('it maps icon with IconFetcher result for file name', () {
    const String absolutePath = '/foo/bar';
    final Node<void> mappedResult = testMappingFile(absolutePath);

    expect(mappedResult.icon, equals(fetcher.mockedIcon));
    expect(fetcher.getIconWasCalledWith, equals(absolutePath));
  });

  test('it maps icon with folder icon for directories', () {
    final Directory entity = Directory('/foo/bar');
    final Node<void> mappedResult = mapper.map(entity);

    expect(mappedResult.icon, equals(Icons.folder));
  });

  test('it maps children with an empty list for files', () {
    final File entity = File('/foo/bar');
    final Node<void> mappedResult = mapper.map(entity);

    expect(mappedResult.children, isEmpty);
  });

  test('it marks children with an empty Node list for directories', () {
    final Directory entity = Directory('/foo/bar');
    final Node<void> mappedResult = mapper.map(entity);

    expect(mappedResult.children.length, equals(1));
    expect(mappedResult.children.first.key, equals('EMPTY_NODE'));
  });

  test('icon is red if the path matches with an untracked directory', () {
    const String untrackedDirectory = '/foo/bar/';
    mapper.status = <StatusFile>[
      const UntrackedPath(untrackedDirectory),
    ];

    final Directory entity = Directory(untrackedDirectory);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(Colors.red));
  });

  test('icon is red if the file is contained in an untracked directory', () {
    const String untrackedDirectory = '/foo/bar/';
    mapper.status = <StatusFile>[const UntrackedPath(untrackedDirectory)];

    final File entity = File('${untrackedDirectory}untrackedFile');
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(Colors.red));
  });

  test('icon is blue if the path matches an updated file', () {
    const String path = '/foo/bar.dart';
    mapper.status = <StatusFile>[const ModifiedFile(path)];

    final File entity = File(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(Colors.blue));
  });

  test('icon is green if the path matches an added file', () {
    const String path = '/foo/bar.dart';
    mapper.status = <StatusFile>[const AddedFile(path)];

    final File entity = File(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(Colors.green));
  });

  test('icon is brown if the path matches an ignored path', () {
    const String path = '/foo/bar/';
    mapper.status = <StatusFile>[const IgnoredFile(path)];

    final Directory entity = Directory(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(Colors.brown));
  });
}

Node<void> testMappingFile(String absolutePath) {
  final File entity = File(absolutePath);
  return mapper.map(entity);
}

class IconFetcherSpy extends Fake implements IconFetcher {
  IconData mockedIcon = Icons.file_copy;
  String? getIconWasCalledWith;

  @override
  IconData getIcon(String fileName) {
    getIconWasCalledWith = fileName;
    return mockedIcon;
  }
}
