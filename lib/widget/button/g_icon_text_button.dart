import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/utils/button_level.dart';

class GIconTextButton extends StatefulWidget {
  GIconTextButton({
    Key? key,
    required this.title,
    required this.icon,
    this.level = ButtonLevel.unknown,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final ButtonLevel level;
  final GestureTapCallback onPressed;

  final Map<ButtonLevel, Color> colorByLevel = <ButtonLevel, Color>{
    ButtonLevel.unknown: NordColors.$0,
    ButtonLevel.careful: Colors.orange,
    ButtonLevel.safe: Colors.green,
    ButtonLevel.risky: Colors.red,
  };

  @override
  State<GIconTextButton> createState() => _GIconTextButtonState();
}

class _GIconTextButtonState extends State<GIconTextButton> {
  late ButtonLevel defaultlevel = ButtonLevel.unknown;

  late Map<ButtonLevel, Color> buttonlevel;
  late ButtonLevel level = defaultlevel;
  late ButtonLevel state;

  @override
  void initState() {
    state = widget.level;
    buttonlevel = widget.colorByLevel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: buttonlevel[level],
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
      ),
      onHover: (PointerHoverEvent s) {
        setState(() {
          level = state;
        });
      },
      onExit: (PointerExitEvent s) {
        setState(() {
          level = defaultlevel;
        });
      },
    );
  }
}
