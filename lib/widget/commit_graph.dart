import 'package:flutter/material.dart';

class CommitTree extends StatelessWidget {
  const CommitTree();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Image.asset(
      'assets/git.png',
      fit: BoxFit.fitWidth,
      width: MediaQuery.of(context).size.width,
    )));
  }
}
