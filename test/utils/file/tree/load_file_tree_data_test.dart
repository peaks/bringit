@Tags(<String>['file-system-dependent'])

import 'dart:io';

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/utils/file/tree/load_file_tree_data.dart';
import 'package:test/test.dart';

const String baseTestPath = '/tmp/git-ihm/nonGitProject/';
late List<FileSystemEntity> entityToClean;

void main() {
  setUp(() {
    entityToClean = <FileSystemEntity>[];
  });

  test('it returns an empty list on empty directory', () {
    final List<Node<void>> result = getNodesFromPath(baseTestPath);
    expect(result.isEmpty, equals(true));
  });

  test('for directories it returns a parent Node labeled with directory name ',
      () {
    const String dirName = 'newDirectory';
    _makeDirectory(dirName);
    final List<Node<void>> result = getNodesFromPath(baseTestPath);

    expect(result.first.label, equals(dirName));
    expect(result.first.isParent, equals(true));
  });

  test('it sorts alphabeticaly', () {
    _makeDirectory('dir2');
    _makeDirectory('dir1');

    final List<Node<void>> result = getNodesFromPath(baseTestPath);

    expect(_getLabels(result), equals(<String>['dir1', 'dir2']));
  });

  test('it sorts directories on top of the list', () {
    _makeDirectory('dir1');
    _createFile('anyName');
    _createFile('anotherName');
    _makeDirectory('dir2');

    final List<Node<void>> result = getNodesFromPath(baseTestPath);

    expect(_getLabels(result),
        equals(<String>['dir1', 'dir2', 'anotherName', 'anyName']));
  });

  tearDown(() {
    for (final FileSystemEntity entity in entityToClean) {
      entity.deleteSync();
    }
  });
}

List<String> _getLabels(List<Node<void>> result) {
  final List<String> nodeLabels = <String>[];
  for (final Node<void> node in result) {
    nodeLabels.add(node.label);
  }
  return nodeLabels;
}

void _createFile(String fileName) {
  final File file = File(_buildFullPath(fileName));
  file.createSync();
  entityToClean.add(file);
}

void _makeDirectory(String dirName) {
  final Directory directory = Directory(_buildFullPath(dirName));
  directory.createSync();
  entityToClean.add(directory);
}

String _buildFullPath(String name) => '$baseTestPath$name';
