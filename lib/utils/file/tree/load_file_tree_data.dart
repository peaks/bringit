import 'dart:io';

/// recursive function to add node
List<Map<String, dynamic>> addToParentNode(List<Map<String, dynamic>> nodes,
    Map<String, dynamic> n, Iterable<String> pathToFile) {
  if (pathToFile.isNotEmpty) {
    for (final Map<String, dynamic> node in nodes) {
      if (node['label'] == pathToFile.first) {
        node['children'] = addToParentNode(
            node['children'] as List<Map<String, dynamic>>,
            n,
            pathToFile.where((String element) => element != pathToFile.first));
      }
    }
  } else {
    nodes.add(n);
  }

  /// sort nodes before render
  nodes.sort((Map<String, dynamic> a, Map<String, dynamic> b) =>
      (a['key'] as String).compareTo(b['key'] as String));
  return nodes;
}

/// get name of a file by uri
String getFileNameByUri(FileSystemEntity file) {
  if (file.uri.toString().contains('/')) {
    final List<String> temp = file.uri.toString().split('/');
    if (temp.isNotEmpty && temp.last != '') {
      return temp.last;
    } else {
      return temp.first;
    }
  } else {
    return file.uri.toString();
  }
}

List<Map<String, dynamic>> getDirFiles(String path, bool docsOpen) {
  /// Create Dir object from existing path
  final Directory myDir = Directory(path);

  /// List all file from dir
  final List<FileSystemEntity> allContent = myDir.listSync(recursive: true);

  /// result
  List<Map<String, dynamic>> nodes = <Map<String, dynamic>>[];

  /// loop items in path
  for (final FileSystemEntity file in allContent) {
    final Map<String, dynamic> n = <String, dynamic>{
      'label': getFileNameByUri(file),
      'key': file.uri.toString(),
      'children': <Map<String, dynamic>>[]
    };

    /// file is located on root of tree
    if (file.parent.path == '.' || file.parent.path == './') {
      nodes.add(n);
    } else {
      final Iterable<String> pathToFile = n['key'].toString().split('/').where(
          (String element) => element.toString() != n['label'].toString());
      nodes = addToParentNode(nodes, n, pathToFile);
    }
  }

  return nodes;
}
