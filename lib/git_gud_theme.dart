import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class GitGudTheme {
  final ThemeData darkTheme = _buildDarkTheme();
  static Color warningColor = NordColors.$11;
  static Color successColor = NordColors.$14;
  static Color unknowColor = NordColors.$0;
  static Color carefulColor = NordColors.$12;
  static Color secondaryColor = NordColors.$8;

  static ThemeData _buildDarkTheme() {
    final ThemeData base = NordTheme.dark();
    return base.copyWith(
      scaffoldBackgroundColor: NordColors.$1,
      primaryColorDark: NordColors.$0,
      textTheme: base.textTheme.copyWith(
        titleLarge: const TextStyle(
          color: NordColors.$8,
          fontSize: 14,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: NordColors.$4,
        ),
        headlineMedium: const TextStyle(
            color: NordColors.$8, fontWeight: FontWeight.w500, fontSize: 18),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        iconColor: NordColors.$4,
        textColor: NordColors.$4,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: NordColors.$0,
      ),
      colorScheme: const ColorScheme.dark(
        primary: NordColors.$4,
        secondary: NordColors.$8,
        tertiary: NordColors.$15,
        background: NordColors.$1,
        surface: NordColors.$3,
      ),
      secondaryHeaderColor: NordColors.$8,
    );
  }
}
