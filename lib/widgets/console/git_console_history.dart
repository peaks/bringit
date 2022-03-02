import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class GitConsoleHistory extends StatefulWidget {
  const GitConsoleHistory(
      {Key? key,
      required this.command,
      required this.stdout,
      required this.stderr,
      required this.success})
      : super(key: key);

  final String command;
  final String stdout;
  final String stderr;
  final bool success;

  @override
  State<GitConsoleHistory> createState() => GitConsoleHistoryState();
}

class GitConsoleHistoryState extends State<GitConsoleHistory> {
  ExpandableController expandableController =
      ExpandableController(initialExpanded: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: expandableController,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.command,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'FantasqueSansMono',
            ),
          ),
          if (widget.success)
            const Icon(
              Icons.check,
              color: Colors.greenAccent,
            )
          else
            const Icon(Icons.error, color: Colors.redAccent)
        ],
      ),
      collapsed: const SizedBox(),
      expanded: Column(
        children: <Text>[
          Text(
            widget.stderr,
            style: const TextStyle(
                color: Colors.redAccent, fontFamily: 'FantasqueSansMono'),
          ),
          Text(
            widget.stdout,
            style: const TextStyle(fontFamily: 'FantasqueSansMono'),
          )
        ],
      ),
      theme: const ExpandableThemeData(
        iconColor: Colors.white,
        headerAlignment: ExpandablePanelHeaderAlignment.center,
      ),
    );
  }

  void expanded(bool expanded) => setState(() {
        expandableController.expanded = expanded;
      });
}
