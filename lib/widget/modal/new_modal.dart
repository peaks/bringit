import 'package:flutter/material.dart';

class NewProjectModal extends StatefulWidget {
  const NewProjectModal(
      {Key? key,
      required this.title,
      required this.icon,
      required this.titleAction,
      required this.onSubmit,
      required this.modalContent})
      : super(key: key);

  final String title;
  final IconData icon;
  final String titleAction;
  final GestureTapCallback onSubmit;
  final Widget modalContent;

  @override
  State<NewProjectModal> createState() => _NewProjectModalState();
}

class _NewProjectModalState extends State<NewProjectModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titlePadding: const EdgeInsets.symmetric(horizontal: 10),
      title: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      widget.icon,
                      size: 16,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.title,
                        style: Theme.of(context).textTheme.displayLarge),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const Divider(
              thickness: 1,
            )
          ],
        ),
      ),
      content: Container(
        child: widget.modalContent,
        width: 800,
      ),
    );
  }
}
