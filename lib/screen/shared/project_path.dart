import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/git_proxy.dart';

class ProjectPath extends StatelessWidget {
  const ProjectPath({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GitProxy>(
        builder: (BuildContext context, GitProxy git, _) =>
            Text('project: ${git.path}'));
  }
}
