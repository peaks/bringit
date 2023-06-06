import 'package:flutter/material.dart';

class ModalActionButton extends StatelessWidget {
  const ModalActionButton(
      {Key? key,
      this.enable = true,
      required this.onSubmit,
      required this.title})
      : super(key: key);

  final bool enable;
  final GestureTapCallback onSubmit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: enable
          ? OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
              side: BorderSide(
                color: Theme.of(context).primaryColorDark,
              ))
          : OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              side: BorderSide(
                color: Theme.of(context).colorScheme.surface,
              )),
      onPressed: enable ? onSubmit : null,
      child: Text(
        title,
        style: enable
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
