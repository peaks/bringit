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
