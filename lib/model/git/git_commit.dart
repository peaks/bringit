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
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class GitCommit {
  const GitCommit(this.hashValue, this.date, this.author, this.email,
      this.subject, this.body,
      [this.references = const <String>[]]);

  final String hashValue;
  final DateTime date;
  final String author;
  final String email;
  final String subject;
  final String body;

  final List<String> references;

  @override
  String toString() {
    return '$hashValue,$date,$author,$email,$subject';
  }

  @override
  int get hashCode => hashValue.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! GitCommit) {
      return false;
    }

    return _hasSameReferences(this, other) &&
        other.hashValue == hashValue &&
        other.date == date &&
        other.author == author &&
        other.subject == subject &&
        other.email == email;
  }

  bool _hasSameReferences(GitCommit source, GitCommit target) {
    const ListEquality<String> comparator = ListEquality<String>();

    return comparator.equals(source.references, target.references);
  }
}
