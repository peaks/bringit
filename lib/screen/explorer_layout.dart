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
            child: Container(
              padding: const EdgeInsets.all(8),
              color: NordColors.$1,
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
                  // file tree to re code but for now to complicated to but in a ScrollablePanelContainer because already contains a scroll management
                  const FileTree(),
                ],
              ),
            ),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: const <Widget>[
                Expanded(
                  flex: 2,
                  child: ScrollablePanelContainer(
                    title: 'Explorer',
                    child: Center(
                      child: Text(
                        'Content',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ScrollablePanelContainer(
                      title: 'Console',
                      child: Center(
                        child: Text(
                          'Content',
                          style: TextStyle(fontSize: 32),
                        ),
                      )),
                ),
              ])),
        ],
      ),
    );
  }
}
