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
import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/data/git_list_commit.dart';
import 'package:git_ihm/widget/commit_info.dart';
import 'package:git_ihm/widget/commit_timestamp.dart';
import 'package:git_ihm/widget/info_user_commit.dart';
import 'package:git_ihm/widget/user_profile_picture.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommitSummary extends StatelessWidget {
  CommitSummary({
    Key? key,
    required this.commitHash,
  }) : super(key: key);

  final String commitHash;

  late final GitCommit commit = getCommit(commitHash);

  String formatDate(DateTime commitDate) {
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('EEEE dd  MMMM yyyy', 'en_Us');
    final String formatted = formatter.format(commitDate);
    return formatted;
  }

  String getTimeAgoCommit(DateTime commitDate) {
    return timeago.format(commitDate);
  }

  @override
  Widget build(BuildContext context) {
    final String commitRelativeDate = getTimeAgoCommit(commit.date);
    final String formmattedDate = formatDate(commit.date);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: UserProfilePicture(userEmail: commit.email),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InfoUserCommit(
                              userAuthor: commit.author,
                              userEmail: commit.email),
                          CommitTimestamp(
                            commitDate: formmattedDate,
                            commitRelativeDate: commitRelativeDate,
                          ),
                        ],
                      ),
                      CommitInfo(
                          commitHash: commit.hashValue,
                          commitsubject: commit.subject,
                          commitBody: commit.body),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
