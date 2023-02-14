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
        Text(commitDate),
        const SizedBox(
          width: 5,
        ),
        Text('($commitRelativeDate)')
      ],
    );
  }
}
