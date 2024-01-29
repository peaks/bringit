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
import 'package:git_ihm/helpers/git_gud_logger.dart';
import 'package:git_ihm/helpers/localization/wording.dart';
import 'package:git_ihm/ui/common/button_level.dart';
import 'package:git_ihm/ui/common/widget/modal/modal_commit.dart';
import 'package:git_ihm/ui/common/widget/modal/modal_commit_content.dart';
import 'package:logger/logger.dart';

import '../shared/button/gamified_icon_text_button.dart';

class StagingButtons extends StatefulWidget {
  const StagingButtons({Key? key}) : super(key: key);

  @override
  State<StagingButtons> createState() => _StagingButtonsState();
}

class _StagingButtonsState extends State<StagingButtons> {
  GitProxy? git;
  late Logger log;

  @override
  void initState() {
    GitFactory().getGit().then((GitProxy gitP) {
      setState(() {
        git = gitP;
      });
    });
    super.initState();
    log = getLogger(runtimeType.toString());
  }

  Future<void> displayModalCommit() async {
    final String userAuthor = await getUserName();
    final String userEmail = await getUserEmail();
    final String branch = await getBranch();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => ModalCommit(
        modalContent: ModalCommitContent(
          userAuthor: userAuthor,
          userEmail: userEmail,
          commitBranch: branch,
        ),
        title: Wording.modalCommitTitle,
        onSubmit: () {},
        titleAction: Wording.homeScreenCreateGitProjectButtonTitle,
      ),
    );
  }

  Future<String> getUserName() async {
    final String path = git!.path;
    final String userName = await git!.gitGetConfigUserName(path);
    return userName;
  }

  Future<String> getUserEmail() async {
    final String path = git!.path;
    final String userEmail = await git!.gitGetConfigUserEmail(path);
    return userEmail;
  }

  Future<String> getBranch() async {
    final String path = git!.path;
    final String branch = await git!.gitBranch(path);
    return branch;
  }

  Future<void> executeGitCommand(
      Future<String> Function(String path) gitCommand) async {
    final String path = git!.path;
    try {
      if (path.isEmpty) {
        log.w('Cannot execute command "$gitCommand": no path is provided');
      }
      gitCommand(path);
    } catch (error) {
      log.w('Cannot execute command "$gitCommand": $error');
    }
  }

  Future<void> addAll() {
    return executeGitCommand((String path) => git!.gitAddAll(path));
  }

  Future<void> restoreStaged() {
    return executeGitCommand((String path) => git!.gitRestoreStagedAll(path));
  }

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
                    title: Wording.gitActionAddAllTitle,
                    icon: Icons.arrow_circle_right_outlined,
                    onPressed: () {
                      addAll();
                    },
                    level: ButtonLevel.safe,
                  ),
                  GamifiedIconTextButton(
                    title: Wording.gitActionRestoreStagedTitle,
                    icon: Icons.arrow_circle_left_outlined,
                    onPressed: () {
                      restoreStaged();
                    },
                    level: ButtonLevel.safe,
                  ),
                ],
              ),
            ),
          ),
          GamifiedIconTextButton(
            title: Wording.gitActionCommitTitle,
            icon: Icons.check,
            onPressed: () {
              displayModalCommit();
            },
            level: ButtonLevel.safe,
          ),
        ],
      ),
    );
  }
}
