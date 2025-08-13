import 'package:flutter/material.dart';

class AppTheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF00838F),
    // 深いティール
    onPrimary: Colors.white,
    secondary: Color(0xFF4DD0E1),
    // 明るいティール
    onSecondary: Colors.black,
    error: Color(0xFFE53935),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF1F2937),
  );

  static ThemeData lightTheme = ThemeData(colorScheme: colorScheme);
}
