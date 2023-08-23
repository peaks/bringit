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
import 'package:flutter/material.dart';
import 'package:git_ihm/ui/common/widget/console/git_console.dart';
import 'package:git_ihm/ui/common/widget/shared/divider_vertical.dart';

/// the 3 main screen are almost the same
/// sections : amount of children in the first part of the screen

class ScreenTemplate extends StatelessWidget {
  const ScreenTemplate(
      {Key? key, required this.sections, required this.children})
      : super(key: key);
  final int sections;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: children.sublist(0, sections)),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child:
                  Column(children: <Widget>[children.last, const GitConsole()]))
        ]));
  }
}
