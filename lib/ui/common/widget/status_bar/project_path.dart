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
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:provider/provider.dart';

class ProjectPath extends StatelessWidget {
  const ProjectPath({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        child: Chip(
            avatar: const Icon(Icons.folder, size: 20),
            label: Consumer<GitProxy>(
              builder: (BuildContext context, GitProxy git, _) => Text(
                git.path,
                overflow: TextOverflow.ellipsis,
              ),
            )));
  }
}
