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
import 'package:git_ihm/model/git/git_commit.dart';
import 'package:test/test.dart';

void main() {
  GitCommit _buildNewCommit(
      {String hash = 'commitHash',
      String email = 'hot@yet.implemente',
      DateTime? date,
      String author = 'John Doe',
      String subject = 'a nice commit',
      String body = 'body commit',
      List<String>? references}) {
    date = (date is DateTime) ? date : DateTime(2022, 12, 25);
    references = (references is List<String>)
        ? references
        : <String>['master', 'first-branch'];

    return GitCommit(hash, date, author, subject, body, email, references);
  }

  test('Two GitCommit instances with same values are equals', () {
    expect(_buildNewCommit() == _buildNewCommit(), true);
  });

  group('On different references:', () {
    test('Different length means different GitCommit', () {
      final List<String> emptyRef = <String>[];
      expect(_buildNewCommit() == _buildNewCommit(references: emptyRef), false);
    });

    test('Different references means different GitCommit', () {
      final List<String> differentRef = <String>['master', 'another-branch'];
      expect(_buildNewCommit() == _buildNewCommit(references: differentRef),
          false);
    });
  });

  test('instances with different hashValue are different', () {
    expect(_buildNewCommit() == _buildNewCommit(hash: 'another-Hash'), false);
  });

  test('instances with different date are different', () {
    final DateTime anotherDate = DateTime(1982, 1, 7);
    expect(_buildNewCommit() == _buildNewCommit(date: anotherDate), false);
  });

  test('instances with different author are different', () {
    expect(_buildNewCommit() == _buildNewCommit(author: 'Jane Doe'), false);
  });

  test('instances with different subject are different', () {
    expect(_buildNewCommit() == _buildNewCommit(subject: 'new subject'), false);
  });
}
