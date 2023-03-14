import 'package:flutter/material.dart';
import 'package:git_ihm/widget/git_chip.dart';
import 'package:git_ihm/widget/project_path.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: <Widget>[
          Divider(
            color: Theme.of(context).primaryColorDark, //color of divider
            thickness: 3,
            endIndent: 3,
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                GitChip(),
                ProjectPath(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
