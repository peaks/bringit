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
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class GitConsoleInput extends StatelessWidget {
  const GitConsoleInput({
    Key? key,
    required this.cmdController,
    required this.cmdFocus,
    required this.lastCommandSucceeded,
    required this.runCommand,
  }) : super(key: key);

  final TextEditingController cmdController;
  final FocusNode cmdFocus;
  final bool lastCommandSucceeded;
  final Function(String p1) runCommand;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NordColors.$1,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextField(
                    controller: cmdController,
                    focusNode: cmdFocus,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      prefixIcon: Text(
                        ' git ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                    onSubmitted: (String command) => runCommand(command),
                  ))),
        ],
      ),
    );
  }
}
