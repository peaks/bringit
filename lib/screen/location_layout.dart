import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/widget/commit_summary.dart';
import 'package:git_ihm/widget/console/git_console.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class LocationLayout extends StatelessWidget {
  const LocationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: <Widget>[
              const ScrollablePanelContainer(
                backgroundColor: NordColors.$1,
                flex: 1,
                title: 'Commit',
                child: Text(
                  'Content',
                ),
              ),
              ScrollablePanelContainer(
                backgroundColor: NordColors.$1,
                flex: 1,
                title: 'Commit Summary',
                child: CommitSummary(
                  commitHash: '454fdf5d',
                ),
              ),
            ]),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: <Widget>[
                const ScrollablePanelContainer(
                  flex: 2,
                  title: 'Locations',
                  child: Center(
                    child: Text(
                      'Content',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: NordColors.$1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Console'.toUpperCase(),
                          style: const TextStyle(color: NordColors.$8),
                        ),
                        const Divider(
                          color: NordColors.$0,
                          thickness: 1,
                        ),
                        const GitConsole(),
                      ],
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
