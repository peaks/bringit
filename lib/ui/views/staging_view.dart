/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/localization/wording.dart';
import 'package:git_ihm/ui/common/widget/shared/scrollable_panel_container.dart';
import 'package:git_ihm/ui/common/widget/staging/status_display.dart';
import 'package:git_ihm/ui/views/view_template.dart';

class StagingScreen extends StatelessWidget {
  StagingScreen({Key? key}) : super(key: key);

  final List<Widget> stagingChildren = <Widget>[
    const ScrollablePanelContainer(
      title: Wording.stagingBlockTitle,
      child: StatusDisplay(),
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
      title: Wording.historyBlockTitle,
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
    return ScreenTemplate(sections: 2, children: stagingChildren);
  }
}
