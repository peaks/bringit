import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

import '../widget/file_tree.dart';

class ExplorerLayout extends StatelessWidget {
  const ExplorerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'File viewer'.toUpperCase(),
                  style: const TextStyle(color: NordColors.$8),
                ),
                const Divider(
                  color: NordColors.$0,
                  thickness: 1,
                ),
                FileTree(),
              ],
            ),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: const <Widget>[
                ScrollablePanelContainer(
                  title: 'Explorer',
                  child: Center(
                    child: Text(
                      'Content',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                ScrollablePanelContainer(
                    title: 'Console',
                    child: Center(
                      child: Text(
                        'Content',
                        style: const TextStyle(fontSize: 32),
                      ),
                    )),
              ])),
        ],
      ),
    );
  }
}
