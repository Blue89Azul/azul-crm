import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/shared/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController    = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: ScreenPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'example@example.com'
                      ),
                      controller: emailController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'azul-crm0123'
                      ),
                      controller: passwordController,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Text('ログイン')
                    )
                  ],
                )
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutePaths.signup);
                },
                child: Text('新規登録はこちら')
            )
          ],
        ),
      ),
    );
  }
}
