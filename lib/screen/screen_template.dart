import 'package:flutter/material.dart';
import 'package:git_ihm/widget/console/git_console.dart';
import 'package:git_ihm/widget/divider_vertical.dart';

/// the 3 main screen are almost the same
/// sections : amount of children in the first part of the screen

class ScreenTemplate extends StatelessWidget {
  const ScreenTemplate(
      {Key? key, required this.sections, required this.children})
      : super(key: key);
  final int sections;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: children.sublist(0, sections)),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child:
                  Column(children: <Widget>[children.last, const GitConsole()]))
        ]));
  }
}
