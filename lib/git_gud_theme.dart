import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class GitGudTheme {
  final ThemeData darkTheme = _buildDarkTheme();
  static Color warningColor = NordColors.$11;
  static Color successColor = NordColors.$14;
  static Color unknowColor = NordColors.$0;
  static Color carefulColor = NordColors.$12;
  static Color secondaryColor = NordColors.$8;
  static Color standardColor = NordColors.$4;

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
          titleMedium: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: NordColors.$4,
            ),
          ),
          titleSmall:
              const TextStyle(fontSize: 16, fontFamily: 'FantasqueSansMono'),
          headlineMedium: const TextStyle(
              color: NordColors.$8, fontWeight: FontWeight.w500, fontSize: 18),
          headlineSmall: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: NordColors.$4)),
          displayMedium: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: NordColors.$15,
            ),
          ),
          displaySmall: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: NordColors.$4,
              decoration: TextDecoration.underline,
            ),
          ),
          headlineLarge: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28,
                  color: NordColors.$4)),
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          iconColor: NordColors.$4,
          textColor: NordColors.$4,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: NordColors.$0,
          textTheme: ButtonTextTheme.normal,
        ),
        colorScheme: const ColorScheme.dark(
          primary: NordColors.$4,
          secondary: NordColors.$8,
          tertiary: NordColors.$15,
          background: NordColors.$1,
          surface: NordColors.$3,
          primaryContainer: NordColors.$9,
          secondaryContainer: NordColors.$2,
        ),
        secondaryHeaderColor: NordColors.$8,
        dividerTheme: const DividerThemeData(
          color: NordColors.$0, //color of divider
          thickness: 3,
          endIndent: 3,
        ));
  }
}
