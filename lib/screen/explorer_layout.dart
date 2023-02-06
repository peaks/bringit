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
          const ScrollablePanelContainer(
            flex: 2,
            title: 'Preview',
            child: Center(
              child: Text(
                'Content',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: NordColors.$1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Explorer'.toUpperCase(),
                          style: const TextStyle(color: NordColors.$8),
                        ),
                        const Divider(
                          color: NordColors.$0,
                          thickness: 1,
                        ),
                        // file tree to re code but for now to complicated to but in a ScrollablePanelContainer because already contains a scroll management
                        const FileTree(),
                      ],
                    ),
                  ),
                ),
                const ScrollablePanelContainer(
                    title: 'Console',
                    child: Center(
                      child: Text(
                        'Content',
                        style: TextStyle(fontSize: 32),
                      ),
                    )),
              ])),
        ],
      ),
    );
  }
}
