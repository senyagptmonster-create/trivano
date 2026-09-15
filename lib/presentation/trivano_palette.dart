import 'package:flutter/material.dart';

class TrivanoPalette {
  static const Color alpineForest = Color(0xFF2D4739);
  static const Color mossLime = Color(0xFF70A03C);
  static const Color graniteGray = Color(0xFF4A5568);
  static const Color cloudPaper = Color(0xFFF7F9F6);
  static const Color cardBorder = Color(0xFFE2E8F0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: cloudPaper,
      colorScheme: const ColorScheme.light(
        primary: alpineForest,
        secondary: mossLime,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: Color(0xFF1A202C),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: alpineForest,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
