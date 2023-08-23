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
@Tags(<String>['file-system-dependent'])

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:git_ihm/ui/common/file/file_tree/file_system_loader.dart';
import 'package:git_ihm/ui/common/file/file_tree/file_system_node_mapper.dart';
import 'package:git_ihm/ui/common/file/file_tree/tree_data_file_loader.dart';
import 'package:git_ihm/ui/common/file/icons/file_icondata.dart';
import 'package:git_ihm/ui/common/utils_factory.dart';
import 'package:path/path.dart' hide equals;

import 'file_system_node_mapper_test.dart';

final FakeUtilsFactory factory = FakeUtilsFactory();
final FakeFileSystemLoader fileSystem = FakeFileSystemLoader();
final IconFetcher iconFetcherSpy = IconFetcherSpy();
final FileSystemNodeMapperSpy nodeMapperSpy = FileSystemNodeMapperSpy();
late TreeDataFileLoader loader;

void main() {
  setUp(() {
    loader = _buildTestSubjectOnFakeFileSystem();
  });

  test('it returns an empty list on empty Directory', () {
    final List<Node<void>> nodes = loader.getNodes('an/empty/directory/path');
    expect(nodes.isEmpty, true);
  });

  test('for directories getNodes returns a parent Node', () {
    fileSystem.pathContent = <FileSystemEntity>[Directory('newDirectory')];
    final List<Node<void>> result = loader.getNodes('path/to/newDirectory');

    expect(_getLabels(result), equals(<String>['newDirectory']));
    expect(result.first.isParent, equals(true));
  });

  test('getNodes keeps list order from FileSystemLoader', () {
    fileSystem.pathContent = <FileSystemEntity>[
      Directory('dir1'),
      Directory('dir2'),
      File('anotherName'),
      File('anyName'),
    ];

    final List<Node<void>> result = loader.getNodes('a/full/directory');

    expect(_getLabels(result),
        equals(<String>['dir1', 'dir2', 'anotherName', 'anyName']));
  });

  test('getNode binds sub-nodes as children of a parent Node', () {
    fileSystem.pathContent = <FileSystemEntity>[
      Directory('dir1'),
      Directory('dir2'),
      File('anotherName'),
      File('anyName'),
    ];

    const String nodePath = 'node/path';
    final Node<void> result = loader.getNode(nodePath);
    expect(result.children, isA<List<Node<void>>>());
    expect(_getLabels(result.children),
        equals(<String>['dir1', 'dir2', 'anotherName', 'anyName']));
    expect(result.key, equals(Directory(nodePath).absolute.path));
    expect(result.label, equals(basename(nodePath)));
    expect(result.expanded, true);
  });

  test('it links its status property to mapper', () {
    final TreeDataFileLoader testSubject = _buildTestSubjectOnFakeNodeMapper();
    final List<GitFileStatus> gitStatus = <GitFileStatus>[
      const UntrackedPath('foo', 'foo')
    ];
    testSubject.status = gitStatus;

    expect(nodeMapperSpy.statusWasSetWith, same(gitStatus));
  });
}

TreeDataFileLoader _buildTestSubjectOnFakeFileSystem() {
  factory.setIconFetcher(iconFetcherSpy);
  factory.setFileSystemLoader(fileSystem);

  return factory.treeDataFileLoader;
}

TreeDataFileLoader _buildTestSubjectOnFakeNodeMapper() {
  factory.setNodeMapper(nodeMapperSpy);

  return factory.treeDataFileLoader;
}

List<String> _getLabels(List<Node<void>> result) {
  final List<String> nodeLabels = <String>[];
  for (final Node<void> node in result) {
    nodeLabels.add(node.label);
  }
  return nodeLabels;
}

class FakeFileSystemLoader extends Fake implements FileSystemLoader {
  List<FileSystemEntity> pathContent = <FileSystemEntity>[];

  @override
  List<FileSystemEntity> list(Directory dir) => pathContent;
}

class FakeUtilsFactory extends UtilsFactory {
  void setFileSystemLoader(FileSystemLoader loader) {
    fileSystemLoader = loader;
  }

  void setIconFetcher(IconFetcher fetcher) {
    iconFetcher = fetcher;
  }

  void setNodeMapper(FileSystemNodeMapper mapper) {
    nodeMapper = mapper;
  }
}

class FileSystemNodeMapperSpy extends Fake implements FileSystemNodeMapper {
  List<GitFileStatus>? statusWasSetWith;

  @override
  set status(List<GitFileStatus> files) {
    statusWasSetWith = files;
  }
}
