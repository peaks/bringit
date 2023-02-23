import 'package:flutter/material.dart';
import 'package:git_ihm/widget/console/git_console.dart';
import 'package:git_ihm/widget/divider_vertical.dart';

/// the 3 main screen are almost the same
/// sections : amount of children in the screen

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({Key? key, this.sections, this.title, required this.children}) : super(key: key);
  final int? sections;
  final String? title;
  final List<Widget>? children;

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
      Expanded(
        flex: 2,
        child: Column(children: widget.children!.sublist(0, widget.sections)),
      ),
      const DividerVertical(),
      Expanded(flex: 1, child: Column(children: <Widget>[widget.children!.last, const GitConsole()]))
    ]));
  }
}
