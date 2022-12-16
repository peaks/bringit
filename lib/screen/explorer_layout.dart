import 'package:flutter/material.dart';
import 'package:git_ihm/utils/placeholder_panel.dart';
import 'package:git_ihm/widget/divider_vertical.dart';

class ExplorerLayout extends StatelessWidget {
  const ExplorerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'File Viewer',
              ),
            ]),
          ),
          const DividerVertical(),
          Expanded(
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Explorer',
                flex: 2,
              ),
              PlaceholderPanel(
                'Console',
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
