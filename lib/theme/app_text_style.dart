import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class AppTextStyle {
  static TextStyle title = GoogleFonts.poppins(
    color: AppColor.grayLight,
    fontSize: 56,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // 見出し
  static TextStyle heading1 = GoogleFonts.poppins(
    color: AppColor.grayDark,
    fontSize: 28, // 大画面用タイトル
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  static TextStyle heading2 = GoogleFonts.poppins(
    color: AppColor.grayDark,
    fontSize: 22, // 画面内セクション見出し
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static TextStyle heading3 = GoogleFonts.poppins(
    color: AppColor.grayDark,
    fontSize: 18, // カードタイトルや小見出し
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  // 本文
  static TextStyle bodyLarge = GoogleFonts.inter(
    color: AppColor.grayDark,
    fontSize: 16, // 一般的な本文
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  static TextStyle bodyMedium = GoogleFonts.inter(
    color: AppColor.grayDark,
    fontSize: 14, // サブテキスト
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  static TextStyle bodySmall = GoogleFonts.inter(
    color: AppColor.grayDark,
    fontSize: 12, // 補足・キャプション
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  // ボタン・ラベル
  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  static TextStyle label = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: Colors.grey,
  );
}