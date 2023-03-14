import 'package:flutter/material.dart';

class CommitTimestamp extends StatelessWidget {
  const CommitTimestamp(
      {Key? key, required this.commitDate, required this.commitRelativeDate})
      : super(key: key);
  final String commitDate;
  final String commitRelativeDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          commitDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '($commitRelativeDate)',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
