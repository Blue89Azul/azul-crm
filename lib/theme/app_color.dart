import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color primaryLight = Color(0xFF60A5FA);

  // Functional Colors
  static const Color accent = Color(0xFF06B6D4);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Gray Colors (最小限)
  static const Color grayLight = Color(0xFFF3F4F6);    // カード背景・補助エリア
  static const Color grayMedium = Color(0xFF9CA3AF);   // サブテキスト・アイコン
  static const Color grayDark = Color(0xFF374151);     // メインテキスト

  // Layout Colors
  static const Color background = Colors.white;        // 画面背景
  static const Color surface = Colors.white;           // 通常カード
  static const Color surfaceGray = grayLight;

  // ステータス
  static const Color hotStates  = Color(0xFFE53935);
  static const Color warmStatus = Color(0xFFFB8C00);
  static const Color coldStatus = Color(0xFF1565C0);
}