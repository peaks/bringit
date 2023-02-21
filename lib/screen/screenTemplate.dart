import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/widget/commit_summary.dart';
import 'package:git_ihm/widget/console/git_console.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/file_tree.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';
import 'package:git_ihm/widget/staging_g_button.dart';

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({Key? key, this.type, this.title}) : super(key: key);
  final int? type;
  final String? title;

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  Widget buildChild(String title, int child) {
    if (title == Wording.locationScreenTitle && child == 2) {
      return CommitSummary(
        commitHash: '454fdf5d',
      );
    } else if (title == Wording.stagingScreenTitle && child == 0) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          color: NordColors.$1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: <Widget>[
                Text(
                  Wording.mapScreenTitles[widget.title]![0],
                  style: const TextStyle(color: NordColors.$8),
                ),
                const Divider(
                  color: NordColors.$0,
                  thickness: 1,
                )
              ]),
              Expanded(
                child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const <Widget>[
                  Text(
                    'Content',
                    style: TextStyle(fontSize: 32),
                  ),
                  StagingGButton()
                ]),
              )
            ],
          ),
        ),
      );
    } else if (title == Wording.explorerScreenTitle && child == 1) {
      return const FileTree();
    } else {
      return const Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: <Widget>[
              if (widget.title == Wording.stagingScreenTitle)
                buildChild(widget.title!, 0)
              else
                ScrollablePanelContainer(
                  flex: 2,
                  title: Wording.mapScreenTitles[widget.title]![0],
                  child: buildChild(widget.title!, 0),
                ),
              if (widget.type == 2)
                ScrollablePanelContainer(
                  backgroundColor: NordColors.$1,
                  flex: 1,
                  title: Wording.mapScreenTitles[widget.title]![2],
                  child: buildChild(widget.title!, 2),
                ),
            ]),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: <Widget>[
                ScrollablePanelContainer(
                  flex: 2,
                  title: Wording.mapScreenTitles[widget.title]![1],
                  child: buildChild(widget.title!, 1),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: NordColors.$1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: const <Widget>[
                        Text(
                          Wording.consoleBlockTitle,
                          style: TextStyle(color: NordColors.$8),
                        ),
                        Divider(
                          color: NordColors.$0,
                          thickness: 1,
                        ),
                        GitConsole(),
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
