import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/screen/screen_template.dart';
import 'package:git_ihm/widget/commit_summary.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class CommitsLayout extends StatelessWidget {
  CommitsLayout({Key? key}) : super(key: key);

  final List<Widget> commitChildren = <Widget>[
    const ScrollablePanelContainer(
      title: Wording.commitBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    ),
    ScrollablePanelContainer(
      title: Wording.commitSummaryBlockTitle,
      child: CommitSummary(
        commitHash: '454fdf5d',
      ),
    ),
    const ScrollablePanelContainer(
      flex: 2,
      title: Wording.locationBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(sections: 2, children: commitChildren);
  }
}
