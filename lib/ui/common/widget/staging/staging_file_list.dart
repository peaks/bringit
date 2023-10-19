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
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:git_ihm/ui/common/button_level.dart';
import 'package:git_ihm/ui/common/widget/shared/button/gamified_icon_button.dart';
import 'package:git_ihm/ui/common/widget/staging/status_file_list.dart';
import 'package:git_ihm/ui/common/widget/staging/status_file_list_header.dart';
import 'package:logger/logger.dart';

class StagingFileList extends StatefulWidget {
  const StagingFileList(
      {Key? key,
      required this.statusFiles,
      required this.title,
      required this.icon,
      required this.iconCommand,
      required this.level})
      : super(key: key);

  final List<GitFileStatus>? statusFiles;
  final String title;
  final IconData icon;
  final IconData iconCommand;
  final ButtonLevel level;

  @override
  State<StagingFileList> createState() => _StagingFileListState();
}

class _StagingFileListState extends State<StagingFileList> {
  late ScrollController _scrollController;
  GitProxy? git;
  String? filePath = '';
  String action = '';
  late Logger log;
  @override
  void initState() {
    GitFactory().getGit().then((GitProxy gitP) {
      setState(() {
        git = gitP;
      });
    });
    super.initState();
    _scrollController = ScrollController();
    log = getLogger(runtimeType.toString());
  }

  Future<void> executeGitCommand(
      Future<String> Function(String path) gitCommand) async {
    final String path = git!.path;
    try {
      if (path.isEmpty) {
        log.w('Cannot execute command "$gitCommand": no path is provided');
      }
      await gitCommand(path);
    } catch (error) {
      log.w('Cannot execute command "$gitCommand": $error');
    }
  }

  Future<void> add(String fileRelativePath) {
    return executeGitCommand(
        (String path) => git!.gitAdd(fileRelativePath, path));
  }

  Future<void> restoreStaged(String fileRelativePath) {
    return executeGitCommand(
        (String path) => git!.gitRestoreStaged(fileRelativePath, path));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StatusFileListHeader(
              title: widget.title,
              icon: widget.icon,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: widget.statusFiles?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StatusFileList(
                        statusFiles: widget.statusFiles?[index],
                        gamifiedIconButton: GamifiedIconButton(
                          level: widget.level,
                          iconCommand: widget.iconCommand,
                          onPressed: () {
                            final String? filePath =
                                widget.statusFiles?[index].fileRelativePath;
                            final String action = widget.title;
                            if (action == Wording.modifiedFiles ||
                                action == Wording.untrackedFiles &&
                                    filePath != null) {
                              add(filePath!);
                            }
                            if (action == Wording.stagedFiles &&
                                filePath != null) {
                              restoreStaged(filePath);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
