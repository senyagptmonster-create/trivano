import 'package:flutter/material.dart';

class TrivanoTheme {
  static const bg = Color(0xFF0D1117);
  static const surface = Color(0xFF161B22);
  static const edge = Color(0xFF21262D);
  static const accent = Color(0xFF10B981);
  static const accentLight = Color(0xFF34D399);
  static const ink = Color(0xFFF0FDF4);
  static const muted = Color(0xFF94A3B8);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: edge, width: 1.5),
        ),
      ),
    );
  }
}
