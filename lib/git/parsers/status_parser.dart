import '../../data/git/status_file.dart';

class StatusParser {
  StatusFile parse(String fileStatus) {
    final String prefixStatus = fileStatus.substring(0, 2);

    switch (prefixStatus) {
      case '??':
        return UntrackedPath(extractSimplePath(fileStatus));
      case ' M':
        return ModifiedFile(extractSimplePath(fileStatus));
      case 'A ':
      case 'M ':
        return AddedFile(extractSimplePath(fileStatus));
      case 'R ':
        return RenamedFile(_extractNewPathFromStatusRenamed(fileStatus));
      default:
        throw Exception('Unexpected prefix "$prefixStatus"');
    }
  }

  String _extractNewPathFromStatusRenamed(String fileStatus) {
    final List<String> pathElements = fileStatus.split('->');
    return pathElements[1].trim();
  }

  String extractSimplePath(String fileStatus) => fileStatus.substring(3);
}
