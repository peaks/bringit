import 'package:git_ihm/data/git/git_commit.dart';

final List<GitCommit> commits = <GitCommit>[
  GitCommit(
    '454fdf5d',
    DateTime.now(),
    'Megane',
    'feat: create summary ',
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  ),
  GitCommit(
      '454fdf5e',
      DateTime.now(),
      'Elsa',
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
      'feat: create summary '),
];

GitCommit getCommit(String hashValue) {
  final GitCommit uniquecommit =
      commits.where((GitCommit commit) => commit.hashValue == hashValue).first;

  return uniquecommit;
}
