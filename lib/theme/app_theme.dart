import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primaryBlue,
    onPrimary: Colors.white,
    secondary: Color(0xFF4DD0E1),
    onSecondary: Colors.black,
    error: Color(0xFFE53935),
    onError: Colors.white,
    surface: AppColor.surface,
    onSurface: Color(0xFF1F2937),
  );

  static ThemeData lightTheme = ThemeData(colorScheme: colorScheme);
}
