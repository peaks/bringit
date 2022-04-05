import '../../data/git/status_file.dart';

class StatusParser {
  StatusFile parse(String s) {
    final String path = s.substring(3);
    final String prefixStatus = s.substring(0, 2);

    switch (prefixStatus) {
      case '??':
        return UntrackedPath(path);
      case ' M':
        return ModifiedFile(path);
      case 'A ':
      case 'M ':
        return AddedFile(path);
      default:
        throw Exception('Unexpected prefix "$prefixStatus"');
    }
  }
}
