// ignore_for_file: avoid_field_initializers_in_const_classes, flutter_style_todos, avoid_classes_with_only_static_members, always_specify_types, overridden_fields

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

/// This file is heavily inspired by https://github.com/Firefnix/flutter-nord-theme/

abstract class NordColorCodes {
  /// Polar night
  static const int $0 = 0xFF2e3440;
  static const int $1 = 0xFF3b4252;
  static const int $2 = 0xFF434c5e;
  static const int $3 = 0xFF4c566a;

  /// Snow Storm
  static const int $4 = 0xFFd8dee9;
  static const int $5 = 0xFFe5e9f0;
  static const int $6 = 0xFFeceff4;

  /// Frost
  static const int $7 = 0xFF8fbcbb;
  static const int $8 = 0xFF88c0d0;
  static const int $9 = 0xFF81a1c1;
  static const int $10 = 0xFF5e81ac;

  /// Aurora
  static const int $11 = 0xFFbf616a;
  static const int $12 = 0xFFd08770;
  static const int $13 = 0xFFebcb8b;
  static const int $14 = 0xFFa3be8c;
  static const int $15 = 0xFFb48ead;
}

class NordAurora {
  const NordAurora();

  final Color red = NordColors.$11;
  final Color orange = NordColors.$12;
  final Color yellow = NordColors.$13;
  final Color green = NordColors.$14;
  final Color purple = NordColors.$15;
}

class NordFrost {
  const NordFrost();

  final Color lightest = NordColors.$7;
  final Color lighter = NordColors.$8;
  final Color darker = NordColors.$9;
  final Color darkest = NordColors.$10;
}

class NordPolarNight {
  const NordPolarNight();

  final Color darkest = NordColors.$0;
  final Color darker = NordColors.$1;
  final Color lighter = NordColors.$2;
  final Color lightest = NordColors.$3;
}

class NordSnowStorm {
  const NordSnowStorm();

  final Color darkest = NordColors.$4;
  final Color medium = NordColors.$5;
  final Color lightest = NordColors.$6;
}

/// The colors of the Nord theme.
///
/// [NordColors] is an abstract class so it can't be instantiated.
/// By default, the colors are with an alpha value of 0xFF.
/// The main source: https://www.nordtheme.com/docs/colors-and-palettes.
abstract class NordColors {
  /// Polar Night is composed of four dark grey colors: darkest ([$0]), darker
  /// ([$1]), lighter ([$2]) and lightest ([$3]).
  ///
  /// The Nord light theme is based on this palette.
  static const NordPolarNight polarNight = NordPolarNight();

  /// A palette made up of three bright grey colors: darkest ([$4]), medium
  /// ([$5]) and lightest ([$6]).
  ///
  /// The Nord light theme is based on this palette.
  static const NordSnowStorm snowStorm = NordSnowStorm();

  /// The heart palette of Nord, a group of four bluish colors: lightest ([$7]),
  /// lighter ([$8]), darker ([$9]) and darkest ([$10]).
  ///
  /// The color schemes of both light and dark themes are based on this palette.
  static const NordFrost frost = NordFrost();

  /// Aurora consists of five vivid, colorful components reminiscent of polar
  /// lights: red ([$11]), orange ([$12]), yellow ([$13]), green ([$14]) and
  /// purple ([$15]).
  static const NordAurora aurora = NordAurora();

  /// The origin color of the Polar Night palette.
  static const Color $0 = Color(NordColorCodes.$0);

  /// A brighter shade color based on [$0].
  static const Color $1 = Color(NordColorCodes.$1);

  /// An even more brighter shade color of [$0]].
  static const Color $2 = Color(NordColorCodes.$2);

  /// The brightest shade color based on [$0].
  static const Color $3 = Color(NordColorCodes.$3);

  /// The origin color or the Snow Storm palette.
  static const Color $4 = Color(NordColorCodes.$4);

  /// A brighter shade color of [$4].
  static const Color $5 = Color(NordColorCodes.$5);

  /// The brightest shade color based on [$4].
  static const Color $6 = Color(NordColorCodes.$6);

  /// A calm and highly contrasted color reminiscent of frozen polar water.
  static const Color $7 = Color(NordColorCodes.$7);

  /// The bright and shiny primary accent color reminiscent of pure and clear
  /// ice.
  static const Color $8 = Color(NordColorCodes.$8);

  /// A more darkened and less saturated color reminiscent of arctic waters.
  static const Color $9 = Color(NordColorCodes.$9);

  /// A dark and intensive color reminiscent of the deep arctic ocean.
  static const Color $10 = Color(NordColorCodes.$10);

  /// A vermilion, yet soothing color.
  static const Color $11 = Color(NordColorCodes.$11);

  /// A saturated, imposing orange color.
  static const Color $12 = Color(NordColorCodes.$12);

  /// A calming yellow color.
  static const Color $13 = Color(NordColorCodes.$13);

  /// A nice, neither too bright nor too dark, green color.
  static const Color $14 = Color(NordColorCodes.$14);

  /// A dark, dull violet color.
  static const Color $15 = Color(NordColorCodes.$15);
}

class NordDarkColorRoles extends NordColorRoles {
  @override
  final Brightness brightness = Brightness.dark;

  @override
  final Color primary = NordColors.frost.lighter;

  @override
  final Color accent = NordColors.frost.darker;

  @override
  final Color text = NordColors.snowStorm.lightest;

  /// Flutter dark theme's is `0x40CCCCCC`.
  @override
  final Color splash = NordColors.$1.withAlpha(0x40);

  @override
  final Color shadow = NordColors.$0.withOpacity(0.25);

  /// Source: Nord's doc.
  @override
  final Color background = NordColors.polarNight.darkest;

  @override
  final Color bottomAppBar = NordColors.polarNight.darkest;

  @override
  final Color dialogBackground = NordColors.polarNight.darker;

  @override
  final Color card = NordColors.$2;

  // TODO: Change dark theme divider color
  @override
  final Color divider = NordColors.$4.withAlpha(50);

  // TODO: Change dark theme focus color
  @override
  final Color focus = NordColors.$3.withAlpha(50);

  // TODO: Change dark theme hover color
  @override
  final Color hover = NordColors.$3.withAlpha(50);

  /// For [ButtonThemeData].
  ///
  /// See [MaterialButton.highlightColor] for a description.
  /// Flutter dark theme's is `0x40CCCCCC`.
  @override
  final Color highlight = NordColors.$1.withAlpha(0x40);

  /// The same as [hover].
  @override
  final Color selectedRow = NordColors.$3.withAlpha(50);

  /// Flutter dark theme's is [Colors.white70] (i.e. `0xB3ffffff`).
  @override
  final Color unselectedWidget = NordColors.snowStorm.lightest.withAlpha(0xB3);

  /// The same as [unselectedWidget].
  @override
  final Color disabled = NordColors.snowStorm.lightest.withAlpha(0xB3);

  /// The color to use for hint text or placeholder text, e.g. in [TextField]
  /// fields.
  @override
  final Color hint = NordColors.snowStorm.darkest;
}

class NordLightColorRoles extends NordColorRoles {
  @override
  final Brightness brightness = Brightness.light;

  @override
  final Color primary = NordColors.frost.darker;

  @override
  final Color accent = NordColors.frost.lighter;

  @override
  final Color text = NordColors.polarNight.darkest;

  /// Flutter dark theme's is `0x40CCCCCC`.
  @override
  final Color splash = NordColors.$1.withAlpha(0x40);

  @override
  final Color background = NordColors.snowStorm.lightest;

  @override
  final Color bottomAppBar = NordColors.snowStorm.medium;

  @override
  final Color dialogBackground = NordColors.snowStorm.medium;

  @override
  final Color card = NordColors.snowStorm.medium;

  @override
  final Color divider = NordColors.$4.withAlpha(100);

  // TODO: Change light theme focus color
  @override
  final Color focus = NordColors.$3.withAlpha(50);

  // TODO: Change light theme hover color
  @override
  final Color hover = NordColors.$3.withAlpha(50);

  /// For [ButtonThemeData].
  ///
  /// See [MaterialButton.highlightColor] for a description.
  /// Flutter dark theme's is `0x40CCCCCC`.
  @override
  final Color highlight = NordColors.$1.withAlpha(0x40);

  /// The same as [hover].
  @override
  final Color selectedRow = NordColors.$3.withAlpha(50);

  /// Flutter dark theme's is [Colors.white70] (i.e. `0xB3ffffff`).
  @override
  final Color unselectedWidget = NordColors.snowStorm.lightest.withAlpha(0xB3);

  /// The same as [unselectedWidget].
  @override
  final Color disabled = NordColors.polarNight.lightest.withAlpha(0x53);

  /// "The color to use for hint text or placeholder text, e.g. in
  /// [TextField] fields." (Flutter's code)
  @override
  final Color hint = NordColors.polarNight.lightest;
}

/// Provides a [light] and a [dark] theme ([ThemeData]).
///
/// This class is abstract so it cannot be instantiated.
/// In reality, this class is an equivalent to [ThemeData], not [Theme].
abstract class NordTheme {
  static final _lightRoles = NordLightColorRoles(),
      _darkRoles = NordDarkColorRoles();

  static final ThemeData _lightTheme = ThemeData.light(),
      _darkTheme = ThemeData.dark();

  /// A light, north-bluish theme.
  static ThemeData light() => _merge(_lightTheme, _lightRoles);

  /// A dark, north-bluish theme.
  static ThemeData dark() => _merge(_darkTheme, _darkRoles);

  static ThemeData _merge(ThemeData original, NordColorRoles roles) =>
      original.copyWith(
        brightness: roles.brightness,
        primaryColor: roles.primary,
        canvasColor: roles.canvas,
        shadowColor: roles.shadow,
        scaffoldBackgroundColor: roles.scaffoldBackground,
        cardColor: roles.card,
        dividerColor: roles.divider,
        focusColor: roles.focus,
        hoverColor: roles.hover,
        highlightColor: roles.highlight,
        splashColor: roles.splash,
        unselectedWidgetColor: roles.unselectedWidget,
        disabledColor: roles.disabled,
        textSelectionTheme: roles.textSelection,
        textButtonTheme: TextButtonThemeData(style: roles.textButton),
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: roles.elevatedButton),
        outlinedButtonTheme:
            OutlinedButtonThemeData(style: roles.outlinedButton),
        switchTheme: roles.switchTheme,
        navigationRailTheme: roles.navigationRail,
        floatingActionButtonTheme: roles.floatingActionButton,
        colorScheme: roles.colorScheme.copyWith(error: roles.error),
        bottomAppBarTheme: BottomAppBarTheme(color: roles.bottomAppBar),
      );
}

/// This class describes the role of each color.
///
/// Based on https://www.nordtheme.com/docs/colors-and-palettes using the
/// corresponding theme. When it is referenced as a source, it means that the
/// page has been investigated with the dev tools of a web browser. Else, the
/// source is just the doc.
///
/// Contains most of the [Color] and sub-themes parameters of [ThemeData]
/// (removing the "-Color" or "-Theme" part in their names).
/// Values that depend on the brightness of the theme (e.g. "primaryColorLight")
/// are not referenced here (for example [ThemeData.primaryColorLight]'s value
/// is actually set in [NordLightColorRoles.primary]).
abstract class NordColorRoles {
  /// This set of color is at the base of the theme.
  ///
  /// Most of the widgets' theme elements can be set from the color scheme, and
  /// in theory, all the other [ThemeData] properties are just overrides.
  ColorScheme get colorScheme => ColorScheme(
        primary: primary,
        secondary: secondary,
        surface: card,
        background: background,
        error: error,
        onPrimary: _lightText,
        onSecondary: _lightText,
        onSurface: text,
        onBackground: text,
        onError: _lightText,
        brightness: brightness,
      );

  /// Either light or dark.
  Brightness get brightness;

  /// The primary color, i.e. the background color for major parts of the app
  /// (toolbars, tab bars, etc).
  Color get primary;

  /// The primary accent color, used next to the [primary] color of the theme.
  Color get accent;

  /// The new, other name of [accent].
  Color get secondary => accent;

  /// The default color for a [Text] widget.
  Color get text;

  /// A light text, used on vivid backgrounds.
  final Color _lightText = NordColors.snowStorm.lightest;

  /// The highlight color used when the text of a [SelectableText] is selected.
  ///
  /// Defaults to a [TextSelectionThemeData] with a selectionColor equal to
  /// [primary].
  TextSelectionThemeData get textSelection => TextSelectionThemeData(
        selectionColor: primary,
      );

  /// The color to use for hint text or placeholder text, e.g. in
  /// [TextField] fields.
  Color get hint;

  Color get splash;

  /// The color of shadows (e.g. for [Card] widgets).
  final Color shadow = const Color(0x590f1115);

  /// A color that contrasts with [primary], e.g. used as the remaining part of
  /// a progress bar.
  Color get background;

  /// The default color of [MaterialType.canvas] [Material].
  ///
  /// Defaults to [background], if not overridden.
  Color get canvas => background;

  /// The default background color of a [Scaffold]. Defaults to [background], if
  /// not overridden.
  Color get scaffoldBackground => background;

  /// [AppBarTheme]'s background color.
  Color get bottomAppBar;

  Color get dialogBackground;

  /// The background color for [Card] widgets.
  Color get card;

  /// For [ListView.separated] among others.
  Color get divider;

  /// The background color for disabled widgets (e.g. if a [Switch] or a
  /// [TextButton] doesn't have a callback function).
  Color get disabled;

  /// The color used for widgets in their inactive (but enabled)
  /// state. For example, an unchecked checkbox. Usually contrasted
  /// with [accent]. See also [disabled].
  Color get unselectedWidget;

  Color get selectedRow;

  Color get focus;

  Color get hover;

  Color get highlight;

  /// The main color used for buttons ([TextButton], [ElevatedButton],
  /// [OutlinedButton]).
  ///
  /// Defaults to [primary], if not overridden.
  Color get button => primary;

  /// The color of the selected tab indicator in a tab bar.
  ///
  /// Defaults to [primary], if not overridden.
  Color get indicator => primary;

  /// The color to use for input validation errors, e.g. in [TextField] fields.
  ///
  /// It is red for both dark and light theme.
  /// Source: Nord's doc.
  final Color error = NordColors.aurora.red;

  /// Used for [Switch], [Radio] and [Checkbox] widgets, among others.
  Color get toggleableActive => primary;

  /// The theme for [TextButton] widgets.
  ButtonStyle get textButton => ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return disabled;
          }
          return button;
        }),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return button.withOpacity(0.04);
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return button.withOpacity(0.12);
          }
          return null;
        }),
      );

  /// The theme for [ElevatedButton] widgets.
  ButtonStyle get elevatedButton => ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          return NordColors.snowStorm.lightest;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          return button;
        }),
      );

  /// The theme for [OutlinedButton] widgets.
  ButtonStyle get outlinedButton => ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.disabled) ? null : button),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return button.withOpacity(0.04);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return button.withOpacity(0.12);
          }
          return null;
        }),
        side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) => states.contains(MaterialState.disabled)
              ? null
              : BorderSide(color: button),
        ),
      );

  /// The theme for [Switch] widgets.
  SwitchThemeData? get switchTheme => null;

  /// The theme for [NavigationRail] widgets.
  NavigationRailThemeData? get navigationRail {
    return NavigationRailThemeData(
      backgroundColor: bottomAppBar,
      unselectedLabelTextStyle: const TextStyle(fontSize: 10),
      selectedLabelTextStyle: TextStyle(
        fontSize: 10,
        color: primary,
      ),
      unselectedIconTheme: const IconThemeData(),
      selectedIconTheme: IconThemeData(color: primary),
    );
  }

  /// The theme for [FloatingActionButton] widgets.
  FloatingActionButtonThemeData? get floatingActionButton {
    return FloatingActionButtonThemeData(
      foregroundColor: NordColors.snowStorm.lightest,
      backgroundColor: primary,
    );
  }
}
