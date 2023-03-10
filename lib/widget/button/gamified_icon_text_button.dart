import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/git_gud_theme.dart';
import 'package:git_ihm/utils/button_level.dart';

class GamifiedIconTextButton extends StatefulWidget {
  GamifiedIconTextButton({
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
  static Duration longPressDuration = const Duration(seconds: 2);

  final Map<ButtonLevel, Color> colorByLevel = <ButtonLevel, Color>{
    ButtonLevel.unknown: GitGudTheme.unknowColor,
    ButtonLevel.careful: GitGudTheme.carefulColor,
    ButtonLevel.safe: GitGudTheme.successColor,
    ButtonLevel.risky: GitGudTheme.warningColor,
  };

  @override
  State<GamifiedIconTextButton> createState() => _GamifiedIconTextButtonState();
}

class _GamifiedIconTextButtonState extends State<GamifiedIconTextButton>
    with SingleTickerProviderStateMixin {
  late ButtonLevel defaultlevel = ButtonLevel.unknown;
  late Map<ButtonLevel, Color> buttonlevel;
  late ButtonLevel level = defaultlevel;
  late ButtonLevel state;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    state = widget.level;
    buttonlevel = widget.colorByLevel;
    super.initState();
    controller = AnimationController(
        duration: GamifiedIconTextButton.longPressDuration, vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
        }
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: InkWell(
        onTapDown: (_) {
          controller.forward();
        },
        onTapUp: (_) {
          controller.stop();
          controller.reset();
        },
        onHover: (_) {
          setState(() {
            level = state;
          });
        },
        child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: buttonlevel[level],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(width: 5),
                Container(
                    height: 18,
                    width: 18,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(
                            value: level == ButtonLevel.risky
                                ? animation.value
                                : 0,
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Center(
                          child: Icon(
                            widget.icon,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    )),
              ],
            )),
      ),
      onExit: (PointerExitEvent s) {
        setState(() {
          level = defaultlevel;
        });
      },
    );
  }
}
