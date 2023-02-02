import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/widget/path_selector.dart';

class ProjectTabBar extends AppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Image.asset(
          'assets/gitlogo.png',
          width: 100,
        ),
      ),
      title: const Text(
        'Project 1',
        style: TextStyle(color: NordColors.$8),
      ),
      actions: const <Widget>[PathSelector()],
    );
    Container(
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
