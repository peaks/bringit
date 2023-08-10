/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:git_ihm/presentation/utils/file/file_tree/file_system_node_mapper.dart';
import 'package:git_ihm/presentation/utils/file/icons/file_icondata.dart';
import 'package:git_ihm/presentation/utils/theme/bringit_theme.dart';

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

  test('icon is yellow if the path matches with an untracked directory', () {
    const String untrackedDirectory = '/foo/bar/';
    mapper.status = <GitFileStatus>[
      const UntrackedPath(untrackedDirectory, untrackedDirectory),
    ];

    final Directory entity = Directory(untrackedDirectory);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(BrinGitTheme.untrackedColor));
  });

  test('icon is red if the file matches with a deleted file', () {
    const String path = '/foo/bar.dart';
    mapper.status = <GitFileStatus>[const DeletedFile(path, path)];

    final File entity = File(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(BrinGitTheme.warningColor));
  });

  test('icon is orange if the path matches an updated file', () {
    const String path = '/foo/bar.dart';
    mapper.status = <GitFileStatus>[const ModifiedFile(path, path)];

    final File entity = File(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(BrinGitTheme.carefulColor));
  });

  test('icon is green if the path matches an added file', () {
    const String path = '/foo/bar.dart';
    mapper.status = <GitFileStatus>[const AddedFile(path, path)];

    final File entity = File(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(BrinGitTheme.successColor));
  });

  test('icon is purple if the path matches an ignored path', () {
    const String path = '/foo/bar/';
    mapper.status = <GitFileStatus>[const IgnoredFile(path, path)];

    final Directory entity = Directory(path);
    final Node<void> mappedResult = mapper.map(entity);
    expect(mappedResult.iconColor, equals(BrinGitTheme.ignoredColor));
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
