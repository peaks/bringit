import 'package:flutter/material.dart';

class CommitInfo extends StatelessWidget {
  const CommitInfo(
      {Key? key,
      required this.commitHash,
      required this.commitsubject,
      required this.commitBody})
      : super(key: key);
  final String commitHash;
  final String commitsubject;
  final String commitBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        shape: InputBorder.none,
        tilePadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        iconColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.primary,
        childrenPadding: const EdgeInsets.only(left: 38.0),
        title: Row(
          children: <Widget>[
            Text(
              commitHash,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(width: 5),
            Text(
              commitsubject,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        children: <Widget>[
          ListTile(
              title: Container(
                  child: Text(
            commitBody,
            style: Theme.of(context).textTheme.titleMedium,
          ))),
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }
}
