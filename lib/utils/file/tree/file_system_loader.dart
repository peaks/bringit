import 'dart:io';

class FileSystemLoader {
  List<FileSystemEntity> list(Directory dir) {
    if (!dir.existsSync()) {
      throw const FileSystemException('No a valid directory');
    }

    return _sortByNamesDirectoriesFirst(dir.listSync());
  }

  List<FileSystemEntity> _sortByNamesDirectoriesFirst(
      List<FileSystemEntity> content) {
    content.sort((FileSystemEntity a, FileSystemEntity b) {
      if (a is Directory && b is! Directory) {
        return -1;
      }

      if (a is! Directory && b is Directory) {
        return 1;
      }

      return a.path.compareTo(b.path);
    });

    return content;
  }
}
