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
import 'package:git_ihm/domain/git/git_factory.dart';
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/ui/common/button_level.dart';
import 'package:git_ihm/ui/common/widget/staging/staging_file_list.dart';

import '../../../../helpers/localization/wording.dart';
import '../../../../model/git/git_file_status.dart';
import 'staging_buttons.dart';

class StatusDisplay extends StatefulWidget {
  const StatusDisplay({Key? key}) : super(key: key);

  @override
  _StatusDisplayState createState() => _StatusDisplayState();
}

class _StatusDisplayState extends State<StatusDisplay> {
  List<GitFileStatus> staged = <GitFileStatus>[];
  List<GitFileStatus> unstaged = <GitFileStatus>[];
  List<GitFileStatus> untracked = <GitFileStatus>[];
  GitProxy? git;

  @override
  void initState() {
    GitFactory().getGit().then((GitProxy gitP) {
      setState(() {
        git = gitP;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (git == null) {
      return const Text(Wording.initializationMessage);
    }

    untracked = git!.gitState
        .where((GitFileStatus element) => element.fileState == null)
        .toList();
    staged = git!.gitState
        .where((GitFileStatus element) =>
            element.fileState == GitDiffFileState.staged)
        .toList();
    unstaged = git!.gitState
        .where((GitFileStatus element) =>
            element.fileState == GitDiffFileState.unstaged)
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height / 2 - 87,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          StagingFileList(
                            statusFiles: unstaged,
                            title: Wording.modifiedFiles,
                            icon: Icons.edit_note,
                            iconCommand: Icons.arrow_circle_right_outlined,
                            level: ButtonLevel.safe,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StagingFileList(
                            title: Wording.untrackedFiles,
                            icon: Icons.visibility_off_outlined,
                            statusFiles: untracked,
                            iconCommand: Icons.arrow_circle_right_outlined,
                            level: ButtonLevel.safe,
                          ), //S
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: StagingFileList(
                        statusFiles: staged,
                        title: Wording.stagedFiles,
                        icon: Icons.task_alt,
                        iconCommand: Icons.arrow_circle_left_outlined,
                        level: ButtonLevel.safe,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const StagingButtons()
          ]),
    );
  }
}
