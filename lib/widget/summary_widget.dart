import 'package:flutter/material.dart';
import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/data/git_list_commit.dart';

class ListCommitSummary extends StatefulWidget {
  const ListCommitSummary({
    Key? key,
    required this.hashValue,
  }) : super(key: key);

  final String hashValue;
  @override
  State<ListCommitSummary> createState() => _ListCommitSummaryState();
}

class _ListCommitSummaryState extends State<ListCommitSummary> {
  late String hash;
  late final GitCommit commit = getCommit(hash);

  @override
  void initState() {
    hash = widget.hashValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('/home/mfoussa/git-ihm/assets/profil.jpg'),
                radius: 25,
              ),
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
                        Row(
                          children: <Widget>[
                            Container(child: Text(commit.author)),
                            Container(child: const Text('email')),
                          ],
                        ),
                        Container(child: Text('${commit.date}')),
                      ],
                    ),
                    Container(
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        title: Text('${commit.hashValue} ${commit.subject}'),
                        children: <Widget>[
                          ListTile(
                              title: Container(
                                  margin: const EdgeInsets.only(left: 38.0),
                                  child: Text(commit.body))),
                        ],
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Row(
                      children: const <Text>[
                        Text('branch name'),
                        Text('version')
                      ],
                    ),
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
