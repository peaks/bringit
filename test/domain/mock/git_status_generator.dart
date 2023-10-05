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

class GitStatusGenerator {
  List<String> _stdout = <String>[];

  String get stdout => _stdout.join('\n');

  void clear() {
    _stdout = <String>[];
  }

  void pushUntrackedResult(String filePath) {
    _stdout.add('?? $filePath');
  }

  void pushRenamedResult(String filePath, String oldFilePath) {
    _stdout.add('R  $oldFilePath -> $filePath');
  }

  void pushRenamedUnstagedResult(String filePath, String oldFilePath) {
    _stdout.add(' R $oldFilePath -> $filePath');
  }

  void pushDeletedUnstagedResult(String filePath) {
    _stdout.add(' D $filePath');
  }

  void pushDeletedStagedResult(String filePath) {
    _stdout.add('D  $filePath');
  }

  void pushModifiedUnstagedResult(String filePath) {
    _stdout.add(' M $filePath');
  }

  void pushModifiedStagedResult(String filePath) {
    _stdout.add('M  $filePath');
  }

  void pushModifiedStagedThenModifiedResult(String filePath) {
    _stdout.add('MM $filePath');
  }

  void pushAdded(String filePath) {
    _stdout.add('A  $filePath');
  }

  void pushAddedModified(String filePath) {
    _stdout.add('AM $filePath');
  }

  void pushIgnoredResult(String filePath) {
    _stdout.add('!! $filePath');
  }
}
