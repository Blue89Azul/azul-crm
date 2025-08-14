import 'package:azul_crm/features/auth/screens/login_screen.dart';
import 'package:azul_crm/features/auth/screens/signup_screen.dart';
import 'package:azul_crm/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MaterialApp(
      title: 'Azul CRM',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
      routes: <String, WidgetBuilder> {
        '/signup': (BuildContext context) => SignUpScreen(),
      },
    ),
  );
}
