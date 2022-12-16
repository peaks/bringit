import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class ProjectTabBar extends StatelessWidget {
  const ProjectTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NordColors.$3,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(
              'assets/gitlogo.png',
              width: 100,
            ),
          ),
          const Text(
            'Project 1',
            style: TextStyle(color: NordColors.$8),
          ),
        ],
      ),
    );
  }
}
