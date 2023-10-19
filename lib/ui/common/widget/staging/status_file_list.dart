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
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:git_ihm/ui/common/widget/shared/button/gamified_icon_button.dart';

class StatusFileList extends StatelessWidget {
  const StatusFileList({
    Key? key,
    required this.gamifiedIconButton,
    required this.statusFiles,
  }) : super(key: key);

  final GamifiedIconButton gamifiedIconButton;
  final GitFileStatus? statusFiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0, left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: statusFiles?.prefix,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.apply(color: statusFiles?.color),
                  children: <InlineSpan>[
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(width: 2),
                    ),
                    TextSpan(
                      text: statusFiles?.fileRelativePath,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          gamifiedIconButton
        ],
      ),
    );
  }
}
