import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/git_proxy.dart';

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
