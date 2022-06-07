import 'package:path/path.dart';

import '../../data/git/status_file.dart';

class StatusParser {
  static const String GIT_RENAMED = 'R ';

  String _projectPath = '';

  void setProject(String prefix) {
    if (prefix.endsWith(separator)) {
      _projectPath = prefix;
      return;
    }
    _projectPath = prefix + separator;
  }

  StatusFile parse(String fileStatus) {
    final String gitPrefix = fileStatus.substring(0, 2);
    final String filePath =
        _projectPath + _extractFilePath(gitPrefix, fileStatus);

    switch (gitPrefix) {
      case '??':
        return UntrackedPath(filePath);
      case ' M':
        return ModifiedFile(filePath);
      case 'A ':
      case 'M ':
        return AddedFile(filePath);
      case '!!':
        return IgnoredFile(filePath);
      case GIT_RENAMED:
        return RenamedFile(filePath);
      default:
        throw Exception('Unexpected prefix "$gitPrefix"');
    }
  }

  String _extractNewName(String fileStatus) {
    final List<String> pathElements = fileStatus.split('->');
    return pathElements[1].trim();
  }

  String _cutFirstThreeCharacters(String fileStatus) => fileStatus.substring(3);

  String _extractFilePath(String gitPrefix, String gitStatusLine) {
    if (gitPrefix == GIT_RENAMED) {
      return _extractNewName(gitStatusLine);
    }

    return _cutFirstThreeCharacters(gitStatusLine);
  }
}
