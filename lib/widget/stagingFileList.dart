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
import 'package:git_ihm/utils/theme/bringit_theme.dart';

import '../data/git/status_file.dart';

class StagingFileList extends StatefulWidget {
  const StagingFileList(
      {Key? key,
      required this.statusFiles,
      required this.title,
      required this.icon})
      : super(key: key);

  final List<StatusFile>? statusFiles;
  final String title;
  final IconData icon;

  @override
  State<StagingFileList> createState() => _StagingFileListState();
}

class _StagingFileListState extends State<StagingFileList> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                widget.icon,
                size: 16,
                color: BrinGitTheme.frostBlue3Color,
              ),
              Expanded(
                child: Container(
                    width: 250,
                    child: Text(widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(overflow: TextOverflow.ellipsis))),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: widget.statusFiles?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.statusFiles?[index].prefix,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.apply(
                                    color: widget.statusFiles?[index].color),
                          ),
                          TextSpan(
                            text: widget.statusFiles?[index].fileRelativePath,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
