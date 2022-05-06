import 'package:flutter/material.dart';
import 'package:git_ihm/data/git_proxy.dart';

class PathSelector extends StatefulWidget {
  const PathSelector(this.git, {Key? key}) : super(key: key);

  final GitProxy git;

  @override
  _PathSelectorState createState() => _PathSelectorState();
}

class _PathSelectorState extends State<PathSelector> {
  TextEditingController pathController = TextEditingController();
  String? pathFieldError;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSelectionModal(context);
        },
        icon: const Icon(Icons.folder));
  }

  InputDecoration buildDecoration(String? error) {
    return InputDecoration(hintText: 'path directory', errorText: error);
  }

  Future<AlertDialog?> showSelectionModal(BuildContext context) async {
    pathController.text = widget.git.path;

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
                          await widget.git.isGitDir(pathController.text);
                      if (isGitDir) {
                        widget.git.path = pathController.text;
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
