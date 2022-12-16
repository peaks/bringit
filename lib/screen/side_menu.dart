import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    this.defaultIndex = 0,
    required this.navigationItems,
    required this.onDestinationSelected,
  }) : super(key: key);

  final int defaultIndex;
  final List<NavigationItem> navigationItems;
  final void Function(int) onDestinationSelected;
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: NordColors.$3,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        selectIndex(index);
        widget.onDestinationSelected(index);
      },
      labelType: NavigationRailLabelType.none,
      destinations: widget.navigationItems
          .map((NavigationItem ni) => ni.navigationRailDestination)
          .toList(),
    );
  }
}

@immutable
class NavigationItem {
  NavigationItem(
      {required this.child,
      required this.icon,
      required this.label,
      Icon? selectedIcon,
      Icon? overIcon})
      : selectedIcon = selectedIcon ?? _copyIconWith(icon),
        overIcon = overIcon ?? _copyIconWith(icon);

  final Widget child;
  final String label;
  final Icon icon;
  final Icon? selectedIcon;
  final Icon? overIcon;

  NavigationRailDestination get navigationRailDestination =>
      NavigationRailDestination(
        icon: icon,
        label: Text(label),
        selectedIcon: selectedIcon,
        padding: const EdgeInsets.all(2),
      );

  static Icon _copyIconWith(Icon source,
      {IconData? icon,
      double? size,
      Color? color,
      String? semanticLabel,
      TextDirection? textDirection,
      List<Shadow>? shadows}) {
    return Icon(
      icon ?? source.icon,
      size: size ?? source.size,
      color: color ?? source.color,
      semanticLabel: semanticLabel ?? source.semanticLabel,
      textDirection: textDirection ?? source.textDirection,
      shadows: shadows ?? source.shadows,
    );
  }
}
