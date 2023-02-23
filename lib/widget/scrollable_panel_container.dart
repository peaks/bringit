import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class ScrollablePanelContainer extends StatelessWidget {
  const ScrollablePanelContainer({Key? key, required this.child, required this.title, this.flex = 1, this.footer}) : super(key: key);
  final Widget child;
  final Widget? footer;
  final String? title;
  final int flex;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Expanded(
        flex: flex,
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: NordColors.$1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title!,
                    style: const TextStyle(color: NordColors.$8),
                  ),
                  const Divider(
                    color: NordColors.$0,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          footer ?? Container()
        ]));
  }
}
