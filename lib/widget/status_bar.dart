import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/widget/git_chip.dart';
import 'package:git_ihm/widget/project_path.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NordColors.$1,
      child: Column(
        children: <Widget>[
          const Divider(
            color: NordColors.$0,
            thickness: 2,
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: const <Widget>[
              GitChip(),
              ProjectPath(),
            ],
          ),
        ],
      ),
    );
  }
}
