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
// ignore_for_file: hash_and_equals
import 'package:flutter/material.dart';
import 'package:git_ihm/ui/theme/bringit_theme.dart';

// added deleted state
enum GitFileState { untracked, modified, added, renamed, ignored, deleted }

// added diff file state list to separate them and switch the state with user actions
enum GitDiffFileState { unstaged, staged }

@immutable
abstract class GitFileStatus {
  // added as optional parameter the diff file state by default to unstaged
  const GitFileStatus(this._fileAbsolutePath, this._fileRelativePath,
      [this._fileState]);

  final String _fileAbsolutePath;
  final String _fileRelativePath;
  final GitDiffFileState? _fileState;

  String get fileAbsolutePath => _fileAbsolutePath;
  String get fileRelativePath => _fileRelativePath;
  GitDiffFileState? get fileState => _fileState;
  Color get color => BrinGitTheme.secondaryColor;
  String get prefix => '!!';

  @override
  bool operator ==(Object other) {
    return other is GitFileStatus && other.fileAbsolutePath == fileAbsolutePath;
  }

  @override
  int get hashCode => fileAbsolutePath.hashCode;

  GitFileState get state;

  @override
  String toString() {
    return '$fileAbsolutePath [$fileState]($prefix)';
  }
}

class UntrackedPath extends GitFileStatus {
  const UntrackedPath(
    String newPath,
    String fileRelativePath,
  ) : super(newPath, fileRelativePath);

  @override
  // pass to yellow to follow figma
  Color get color => BrinGitTheme.untrackedColor;

  @override
  String get prefix => 'U ';

  @override
  GitFileState get state => GitFileState.untracked;

  @override
  bool operator ==(Object other) {
    return other is UntrackedPath && super == other;
  }
}

class AddedFile extends GitFileStatus {
  const AddedFile(String newPath, String fileRelativePath,
      [GitDiffFileState fileState = GitDiffFileState.unstaged])
      : super(newPath, fileRelativePath, fileState);

  @override
  Color get color => BrinGitTheme.successColor;

  @override
  String get prefix => 'A ';

  @override
  GitFileState get state => GitFileState.added;

  @override
  bool operator ==(Object other) {
    return other is AddedFile && super == other;
  }
}

class ModifiedFile extends GitFileStatus {
  const ModifiedFile(String newPath, String fileRelativePath,
      [GitDiffFileState fileState = GitDiffFileState.unstaged])
      : super(newPath, fileRelativePath, fileState);

  @override
  Color get color => BrinGitTheme.carefulColor;

  @override
  String get prefix => 'M ';

  @override
  GitFileState get state => GitFileState.modified;

  @override
  bool operator ==(Object other) {
    return other is ModifiedFile && super == other;
  }
}

class RenamedFile extends GitFileStatus {
  const RenamedFile(String newPath, String fileRelativePath,
      [GitDiffFileState fileState = GitDiffFileState.unstaged])
      : super(newPath, fileRelativePath, fileState);

  @override
  Color get color => BrinGitTheme.successColor;

  @override
  String get prefix => 'R ';

  @override
  GitFileState get state => GitFileState.renamed;

  @override
  bool operator ==(Object other) {
    return other is RenamedFile && super == other;
  }
}

class IgnoredFile extends GitFileStatus {
  const IgnoredFile(String newPath, String fileRelativePath,
      [GitDiffFileState fileState = GitDiffFileState.unstaged])
      : super(newPath, fileRelativePath, fileState);

  @override
  Color get color => BrinGitTheme.ignoredColor;

  @override
  GitFileState get state => GitFileState.ignored;

  @override
  bool operator ==(Object other) {
    return other is IgnoredFile && super == other;
  }
}

// added deleted state
class DeletedFile extends GitFileStatus {
  const DeletedFile(String newPath, String fileRelativePath,
      [GitDiffFileState fileState = GitDiffFileState.unstaged])
      : super(newPath, fileRelativePath, fileState);

  @override
  Color get color => BrinGitTheme.warningColor;

  @override
  String get prefix => 'D ';

  @override
  GitFileState get state => GitFileState.deleted;

  @override
  bool operator ==(Object other) {
    return other is DeletedFile && super == other;
  }
}
