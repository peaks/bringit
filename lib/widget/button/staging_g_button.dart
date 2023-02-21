import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/utils/button_level.dart';

import 'button/gamified_icon_text_button.dart';

class StagingGButton extends StatelessWidget {
  const StagingGButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NordColors.$1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Wrap(
              children: <Widget>[
                GamifiedIconTextButton(
                  title: 'Restore',
                  icon: Icons.restore,
                  onPressed: () {},
                  level: ButtonLevel.risky,
                ),
                GamifiedIconTextButton(
                  title: 'Add All',
                  icon: Icons.arrow_circle_right_rounded,
                  onPressed: () {},
                  level: ButtonLevel.safe,
                ),
                GamifiedIconTextButton(
                  title: 'Stash',
                  icon: Icons.cloud_download,
                  onPressed: () {},
                  level: ButtonLevel.safe,
                ),
                GamifiedIconTextButton(
                  title: 'Restore staged',
                  icon: Icons.arrow_circle_left_rounded,
                  onPressed: () {},
                  level: ButtonLevel.safe,
                ),
                GamifiedIconTextButton(
                  title: 'Delete',
                  icon: Icons.delete,
                  onPressed: () {},
                  level: ButtonLevel.risky,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              GamifiedIconTextButton(
                title: 'Commit',
                icon: Icons.check,
                onPressed: () {},
                level: ButtonLevel.safe,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
