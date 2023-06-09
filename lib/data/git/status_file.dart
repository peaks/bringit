/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
// ignore_for_file: hash_and_equals
import 'package:flutter/material.dart';

enum GitFileState { untracked, modified, added, renamed, ignored }

@immutable
abstract class StatusFile {
  const StatusFile(this._path);

  final String _path;

  String get path => _path;
  Color get color => Colors.white;

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
  Color get color => Colors.red;

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
  Color get color => Colors.green;

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
  Color get color => Colors.blue;

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
  Color get color => Colors.green;

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
  Color get color => Colors.brown;

  @override
  GitFileState get state => GitFileState.ignored;

  @override
  bool operator ==(Object other) {
    return other is IgnoredFile && super == other;
  }
}
