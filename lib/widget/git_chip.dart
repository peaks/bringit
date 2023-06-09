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
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../data/git_proxy.dart';

class GitChip extends StatelessWidget {
  const GitChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // chip are usually used to display deletable items
    // TODO(thibault): use better suited widget
    return Chip(
        avatar: const Icon(MdiIcons.git, size: 20),
        label: Consumer<GitProxy>(
          builder: (BuildContext context, GitProxy git, _) =>
              FutureBuilder<String>(
            future: git.gitVersion(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              String versionMessage = 'fetching git version...';
              if (snapshot.hasData) {
                versionMessage = snapshot.data!;
              }
              return Text(versionMessage,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold));
            },
          ),
        ));
  }
}
