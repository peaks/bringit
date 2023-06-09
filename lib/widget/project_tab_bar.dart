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

class ProjectTabBar extends StatelessWidget {
  const ProjectTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NordColors.$3,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(
              'assets/gitlogo.png',
              width: 100,
            ),
          ),
          const Text(
            'Project 1',
            style: TextStyle(color: NordColors.$8),
          ),
        ],
      ),
    );
  }
}
