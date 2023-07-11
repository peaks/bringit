/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_ihm/utils/button_level.dart';
import 'package:git_ihm/utils/theme/bringit_theme.dart';

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
  static bool isGamificationEnabled = true;
  static Duration longPressDuration = const Duration(seconds: 2);
  final Map<ButtonLevel, Color> colorByLevel = <ButtonLevel, Color>{
    ButtonLevel.unknown: BrinGitTheme.unknowColor,
    ButtonLevel.careful: BrinGitTheme.carefulColor,
    ButtonLevel.safe: BrinGitTheme.successColor,
    ButtonLevel.risky: BrinGitTheme.warningColor,
    ButtonLevel.standard: BrinGitTheme.standardColor,
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
  Color hovercolor = BrinGitTheme.unknowColor;

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
            if (GamifiedIconTextButton.isGamificationEnabled == false) {
              hovercolor = BrinGitTheme.standardColor;
              level = defaultlevel;
            } else {
              level = state;
            }
          });
        },
        child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: buttonlevel[level],
                borderRadius: BorderRadius.circular(5),
                border: GamifiedIconTextButton.isGamificationEnabled == true
                    ? Border.all(style: BorderStyle.none)
                    : Border.all(
                        color: hovercolor, style: BorderStyle.solid, width: 2)),
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
                            value: level == ButtonLevel.risky &&
                                    GamifiedIconTextButton
                                            .isGamificationEnabled ==
                                        true
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
          hovercolor = BrinGitTheme.unknowColor;
        });
      },
    );
  }
}
