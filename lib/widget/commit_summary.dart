import 'package:flutter/material.dart';
import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/data/git_list_commit.dart';
import 'package:git_ihm/widget/commit_info.dart';
import 'package:git_ihm/widget/commit_timestamp.dart';
import 'package:git_ihm/widget/info_user_commit.dart';
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
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/utilisateur.png'),
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.primary,
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
                            userAuthor: commit.author, userEmail: commit.email),
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
    );
  }
}
