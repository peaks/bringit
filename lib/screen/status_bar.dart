import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('STATUS BAR'),
            ],
          ),
        ],
      ),
    );
  }
}
