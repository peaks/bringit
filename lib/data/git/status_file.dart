// ignore_for_file: hash_and_equals
import 'package:flutter/cupertino.dart';

enum GitFileState { untracked, modified, added, renamed, ignored }

@immutable
abstract class StatusFile {
  const StatusFile(this._path);

  final String _path;

  String get path => _path;

  @override
  bool operator ==(Object other) {
    return other is StatusFile && other.path == path;
  }

  @override
  int get hashCode => path.hashCode;

  GitFileState get state;
}

class UntrackedPath extends StatusFile {
  const UntrackedPath(String path) : super(path);

  @override
  GitFileState get state => GitFileState.untracked;

  @override
  bool operator ==(Object other) {
    return other is UntrackedPath && super == other;
  }
}

class AddedFile extends StatusFile {
  const AddedFile(String path) : super(path);

  @override
  GitFileState get state => GitFileState.added;

  @override
  bool operator ==(Object other) {
    return other is AddedFile && super == other;
  }
}

class ModifiedFile extends StatusFile {
  const ModifiedFile(String path) : super(path);

  @override
  GitFileState get state => GitFileState.modified;

  @override
  bool operator ==(Object other) {
    return other is ModifiedFile && super == other;
  }
}

class RenamedFile extends StatusFile {
  const RenamedFile(String newPath) : super(newPath);

  @override
  GitFileState get state => GitFileState.renamed;

  @override
  bool operator ==(Object other) {
    return other is RenamedFile && super == other;
  }
}

class IgnoredFile extends StatusFile {
  const IgnoredFile(String newPath) : super(newPath);

  @override
  GitFileState get state => GitFileState.ignored;

  @override
  bool operator ==(Object other) {
    return other is IgnoredFile && super == other;
  }
}
