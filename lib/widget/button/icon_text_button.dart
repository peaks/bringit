import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/git_gud_theme.dart';

class IconTextButton extends StatefulWidget {
  const IconTextButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  State<IconTextButton> createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  Color hovercolor = GitGudTheme.unknowColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: GitGudTheme.unknowColor,
          side: BorderSide(
            color: hovercolor,
          ),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.title),
            const SizedBox(
              width: 5,
            ),
            Icon(
              widget.icon,
              size: 16,
            ),
          ],
        ),
      ),
      onHover: (PointerHoverEvent s) {
        setState(() {
          hovercolor = Theme.of(context).colorScheme.primary;
        });
      },
      onExit: (PointerExitEvent s) {
        setState(() {
          hovercolor = GitGudTheme.unknowColor;
        });
      },
    );
  }
}
