import 'package:flutter/material.dart';

@immutable
class GitCommit {
  const GitCommit(this.hashValue, this.date, this.author, this.subject,
      [this.references = const <String>[]]);

  final String hashValue;
  final DateTime date;
  final String author;
  final String subject;
  final List<String> references;

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
    if (source.references.length != target.references.length) {
      return false;
    }

    for (final String ref in source.references) {
      if (!target.references.contains(ref)) {
        return false;
      }
    }

    return true;
  }
}
