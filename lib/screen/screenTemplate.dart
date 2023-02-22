import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/widget/button/staging_g_button.dart';
import 'package:git_ihm/widget/commit_summary.dart';
import 'package:git_ihm/widget/console/git_console.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/file_tree.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

/// the 3 main screen are almost the same
/// type 1 has only one child int the first column of the row

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({Key? key, this.type, this.title}) : super(key: key);
  final int? type;
  final String? title;

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  /// OPEN to refactor
  Widget buildChild(String title, int child) {
    if (title == Wording.locationScreenTitle && child == 2) {
      return CommitSummary(
        commitHash: '454fdf5d',
      );
    } else if (title == Wording.stagingScreenTitle && child == 0) {
      // different for now because buttons are not in a scroll view (maybe redefine "ScrollablePanelContainer")
      return Expanded(
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          ScrollablePanelContainer(
            flex: 1,
            title: Wording.mapScreenTitles[widget.title]![0],
            child: const Center(
              child: Text(
                'Content',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          // height here otherwise test crash
          Container(height: 60, child: const StagingGButton())
        ]),
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
                  title: Wording.mapScreenTitles[widget.title]![0],
                  child: buildChild(widget.title!, 0),
                ),
              if (widget.type == 2)
                ScrollablePanelContainer(
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
                  // usage of mapped titles ex : title staging elem 1 = COMMIT
                  title: Wording.mapScreenTitles[widget.title]![1],
                  child: buildChild(widget.title!, 1),
                ),

                // try to put in ScrollablePanelContainer with console as child
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
