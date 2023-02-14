import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

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
        iconColor: NordColors.$4,
        textColor: NordColors.$4,
        childrenPadding: const EdgeInsets.only(left: 38.0),
        title: Row(
          children: <Widget>[
            Text(
              commitHash,
              style: const TextStyle(color: NordColors.$11),
            ),
            const SizedBox(width: 5),
            Text(commitsubject)
          ],
        ),
        children: <Widget>[
          ListTile(title: Container(child: Text(commitBody))),
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }
}
