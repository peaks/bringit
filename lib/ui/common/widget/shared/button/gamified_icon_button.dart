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
import 'package:git_ihm/ui/common/button_level.dart';
import 'package:git_ihm/ui/theme/bringit_theme.dart';
import 'package:logger/logger.dart';

import '../../../../../helpers/git_gud_logger.dart';

class GamifiedIconButton extends StatefulWidget {
  GamifiedIconButton({
    Key? key,
    required this.iconCommand,
    this.level = ButtonLevel.standard,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconCommand;
  final ButtonLevel level;
  final GestureTapCallback onPressed;
  static bool isGamificationEnabled = true;
  final Map<ButtonLevel, Color> colorByLevel = <ButtonLevel, Color>{
    ButtonLevel.careful: BrinGitTheme.carefulColor,
    ButtonLevel.safe: BrinGitTheme.successColor,
    ButtonLevel.risky: BrinGitTheme.warningColor,
    ButtonLevel.standard: BrinGitTheme.standardColor,
  };

  @override
  State<GamifiedIconButton> createState() => _GamifiedIconButtonState();
}

class _GamifiedIconButtonState extends State<GamifiedIconButton>
    with SingleTickerProviderStateMixin {
  late ButtonLevel defaultlevel = ButtonLevel.standard;
  late Map<ButtonLevel, Color> buttonlevel;
  late ButtonLevel level = defaultlevel;

  late ButtonLevel state;

  Color hovercolor = BrinGitTheme.standardColor;
  late Logger log;

  @override
  void initState() {
    state = widget.level;
    log = getLogger(runtimeType.toString());
    buttonlevel = widget.colorByLevel;
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: InkWell(
        onTapUp: (_) {
          widget.onPressed();
        },
        onHover: (_) {
          setState(() {
            if (GamifiedIconButton.isGamificationEnabled == false) {
              hovercolor = BrinGitTheme.standardColor;
              level = defaultlevel;
            } else {
              level = state;
            }
          });
        },
        child: Icon(
          widget.iconCommand,
          size: 18,
          color: buttonlevel[level],
        ),
      ),
      onExit: (PointerExitEvent s) {
        setState(() {
          level = defaultlevel;
          hovercolor = BrinGitTheme.standardColor;
        });
      },
    );
  }
}
