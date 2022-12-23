import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

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
  Color hovercolor = NordColors.$0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: NordColors.$0,
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
          hovercolor = Colors.white;
        });
      },
      onExit: (PointerExitEvent s) {
        setState(() {
          hovercolor = NordColors.$0;
        });
      },
    );
  }
}
