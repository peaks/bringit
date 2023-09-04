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
import 'package:git_ihm/ui/common/button_level.dart';

import '../shared/button/gamified_icon_text_button.dart';

class StagingButtons extends StatelessWidget {
  const StagingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GamifiedIconTextButton(
                    title: Wording.gitActionRestoreTitle,
                    icon: Icons.restore,
                    onPressed: () {},
                    level: ButtonLevel.risky,
                  ),
                  GamifiedIconTextButton(
                    title: Wording.gitActionAddAllTitle,
                    icon: Icons.arrow_circle_right_rounded,
                    onPressed: () {},
                    level: ButtonLevel.safe,
                  ),
                  GamifiedIconTextButton(
                    title: Wording.gitActionStashTitle,
                    icon: Icons.cloud_download,
                    onPressed: () {},
                    level: ButtonLevel.safe,
                  ),
                  GamifiedIconTextButton(
                    title: Wording.gitActionRestoreStagedTitle,
                    icon: Icons.arrow_circle_left_rounded,
                    onPressed: () {},
                    level: ButtonLevel.safe,
                  ),
                  GamifiedIconTextButton(
                    title: Wording.gitActionDeleteTitle,
                    icon: Icons.delete,
                    onPressed: () {},
                    level: ButtonLevel.risky,
                  ),
                  //   const Spacer(),
                ],
              ),
            ),
          ),
          GamifiedIconTextButton(
            title: Wording.gitActionCommitTitle,
            icon: Icons.check,
            onPressed: () {},
            level: ButtonLevel.safe,
          )
        ],
      ),
    );
  }
}
