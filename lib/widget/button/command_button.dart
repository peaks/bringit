/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:flutter/material.dart';
import 'package:git_ihm/utils/command_level_enum.dart';

class CommandButton extends StatelessWidget {
  CommandButton(
      {required this.title,
      required this.onPressed,
      this.level = CommandLevel.unknown});
  final String title;
  final GestureTapCallback onPressed;
  final CommandLevel level;

  final Map<CommandLevel, Color> colorByLevel = <CommandLevel, Color>{
    CommandLevel.unknown: Colors.grey,
    CommandLevel.info: Colors.blue,
    CommandLevel.remote: Colors.orange,
    CommandLevel.safe: Colors.green,
    CommandLevel.dangerous: Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RawMaterialButton(
          fillColor: colorByLevel[level],
          splashColor: colorByLevel[level],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onPressed: onPressed,
          shape: const StadiumBorder(),
        ));
  }
}
