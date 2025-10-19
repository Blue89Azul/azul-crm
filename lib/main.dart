import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp.router(
      title: 'Azul CRM',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    ),
  );
}
