import 'package:flutter/material.dart';

class InfoUserCommit extends StatelessWidget {
  const InfoUserCommit(
      {Key? key, required this.userAuthor, required this.userEmail})
      : super(key: key);
  final String userAuthor;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            child: Text(
          userAuthor,
          style: Theme.of(context).textTheme.titleMedium,
        )),
        const SizedBox(
          width: 5,
        ),
        Container(
            child: Text(
          userEmail,
          style: Theme.of(context).textTheme.displaySmall,
        )),
      ],
    );
  }
}
