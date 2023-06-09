/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
// ignore_for_file: implementation_imports

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:easy_sidemenu/src/global/global.dart';
import 'package:easy_sidemenu/src/side_menu_toggle.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  /// ### Easy Sidemenu widget
  ///
  /// Sidemenu is a menu that is usually located
  /// on the left or right of the page and can used for navigation
  const SideMenu({
    Key? key,
    required this.items,
    required this.controller,
    this.title,
    this.footer,
    this.style,
    this.showToggle = false,
    this.onDisplayModeChanged,
    this.alwaysShowFooter = false,
    this.collapseWidth = 600,
  }) : super(key: key);

  /// Page controller to control [PageView] widget
  final SideMenuController controller;

  /// List of [SideMenuItem] to show them on [SideMenu]
  final List<SideMenuItem> items;

  /// Title widget will shows on top of all items,
  /// it can be a logo or a Title text
  final Widget? title;

  /// Footer widget will show on bottom of [SideMenu]
  /// when [displayMode] was SideMenuDisplayMode.open
  final Widget? footer;

  /// [SideMenu] can be configured by this
  final SideMenuStyle? style;

  /// Show toggle button to switch between open and compact display mode
  /// If the display mode is auto, this button will not be displayed
  final bool? showToggle;

  /// By default footer only shown when display mode is open
  /// If you want always shown footer set it to true
  final bool? alwaysShowFooter;

  /// Notify when [SideMenuDisplayMode] changed
  final ValueChanged<SideMenuDisplayMode>? onDisplayModeChanged;

  /// Width when will our open menu collapse into the compact one
  final int? collapseWidth;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  double _currentWidth = 0;
  late bool showToggle;
  late bool alwaysShowFooter;
  late int collapseWidth;

  @override
  void initState() {
    super.initState();
    showToggle = widget.showToggle ?? false;
    alwaysShowFooter = widget.alwaysShowFooter ?? false;
    collapseWidth = widget.collapseWidth ?? 600;
  }

  @override
  void didUpdateWidget(covariant SideMenu oldWidget) {
    showToggle = widget.showToggle ?? false;
    alwaysShowFooter = widget.alwaysShowFooter ?? false;
    collapseWidth = widget.collapseWidth ?? 600;
    super.didUpdateWidget(oldWidget);
  }

  void _notifyParent() {
    if (widget.onDisplayModeChanged != null) {
      widget.onDisplayModeChanged!(Global.displayModeState.value);
    }
  }

  /// Set [SideMenu] width according to displayMode and notify parent widget
  double _widthSize(SideMenuDisplayMode mode, BuildContext context) {
    if (mode == SideMenuDisplayMode.compact &&
        Global.displayModeState.value != SideMenuDisplayMode.compact) {
      Global.displayModeState.change(SideMenuDisplayMode.compact);
      _notifyParent();
      Global.showTrailing = false;
      return Global.style.compactSideMenuWidth ?? 50;
    }
    return _currentWidth;
  }

  Decoration _decoration(SideMenuStyle? menuStyle) {
    if (menuStyle == null || menuStyle.decoration == null) {
      return BoxDecoration(
        color: Global.style.backgroundColor,
      );
    } else {
      if (menuStyle.backgroundColor != null) {
        menuStyle.decoration =
            menuStyle.decoration!.copyWith(color: menuStyle.backgroundColor);
      }
      return menuStyle.decoration!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Global.controller = widget.controller;
    widget.items.sort(
        (SideMenuItem a, SideMenuItem b) => a.priority.compareTo(b.priority));
    Global.style = widget.style ?? SideMenuStyle();
    _currentWidth = _widthSize(
        Global.style.displayMode ?? SideMenuDisplayMode.auto, context);

    return Container(
      width: _currentWidth,
      height: MediaQuery.of(context).size.height,
      decoration: _decoration(widget.style),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (Global.style.displayMode == SideMenuDisplayMode.compact &&
                    showToggle)
                  const SizedBox(
                    height: 42,
                  ),
                if (widget.title != null) widget.title!,
                ...widget.items,
              ],
            ),
          ),
          if ((widget.footer != null &&
                  Global.displayModeState.value !=
                      SideMenuDisplayMode.compact) ||
              (widget.footer != null && alwaysShowFooter))
            Align(alignment: Alignment.bottomCenter, child: widget.footer!),
          if (Global.style.displayMode != SideMenuDisplayMode.auto &&
              showToggle)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      Global.displayModeState.value == SideMenuDisplayMode.open
                          ? 0
                          : 4,
                  vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SideMenuToggle(
                    onTap: () {
                      if (Global.displayModeState.value ==
                          SideMenuDisplayMode.compact) {
                        setState(() {
                          Global.style.displayMode = SideMenuDisplayMode.open;
                        });
                      } else if (Global.displayModeState.value ==
                          SideMenuDisplayMode.open) {
                        setState(() {
                          Global.style.displayMode =
                              SideMenuDisplayMode.compact;
                        });
                      }
                    },
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
