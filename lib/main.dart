import 'package:azul_crm/features/auth/screens/login_screen.dart';
import 'package:azul_crm/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Azul CRM',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
  ));
}
