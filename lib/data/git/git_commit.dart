import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class GitCommit {
  const GitCommit(
      this.hashValue, this.date, this.author, this.subject, this.body,
      [this.references = const <String>[]]);

  final String hashValue;
  final DateTime date;
  final String author;
  final String subject;

  final List<String> references;
  final String body;

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
        other.subject == subject;
  }

  bool _hasSameReferences(GitCommit source, GitCommit target) {
    const ListEquality<String> comparator = ListEquality<String>();

    return comparator.equals(source.references, target.references);
  }
}
