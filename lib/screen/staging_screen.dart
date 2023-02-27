import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/screen/screen_template.dart';
import 'package:git_ihm/widget/button/staging_g_button.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class StagingScreen extends StatelessWidget {
  StagingScreen({Key? key}) : super(key: key);

  final List<Widget> stagingChildren = <Widget>[
    const ScrollablePanelContainer(
      title: Wording.stagingBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
      footer: StagingGButton(),
    ),
    const ScrollablePanelContainer(
      title: Wording.diffBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    ),
    const ScrollablePanelContainer(
      flex: 2,
      title: Wording.commitBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(sections: 2, children: stagingChildren);
  }
}
