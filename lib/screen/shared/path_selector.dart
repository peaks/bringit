import 'package:flutter/material.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:provider/provider.dart';

class PathSelector extends StatefulWidget {
  const PathSelector({Key? key}) : super(key: key);

  @override
  _PathSelectorState createState() => _PathSelectorState();
}

class _PathSelectorState extends State<PathSelector> {
  TextEditingController pathController = TextEditingController();
  String? pathFieldError;

  @override
  Widget build(BuildContext context) {
    return Consumer<GitProxy>(
        builder: (BuildContext context, GitProxy notifier, _) => IconButton(
            onPressed: () {
              showSelectionModal(context, notifier);
            },
            icon: const Icon(Icons.folder)));
  }

  InputDecoration buildDecoration(String? error) {
    return InputDecoration(hintText: 'path directory', errorText: error);
  }

  Future<AlertDialog?> showSelectionModal(
      BuildContext context, GitProxy git) async {
    pathController.text = git.path;

    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Set project path'),
              content: TextField(
                controller: pathController,
                decoration: buildDecoration(pathFieldError),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      final bool isGitDir =
                          await git.isGitDir(pathController.text);
                      if (isGitDir) {
                        git.path = pathController.text;
                        Navigator.pop(context);
                      } else {
                        pathFieldError = 'not a git directory';
                      }
                      setState(() {});
                    },
                    child: const Text('Save'))
              ],
            );
          });
        });
  }
}
