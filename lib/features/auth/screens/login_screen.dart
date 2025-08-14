import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
                'assets/logo.svg',
              semanticsLabel: 'AZUL CRM',
            ),
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'example@example.com'
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'azul-crm0123'
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text('ログイン')
                    )
                  ],
                )
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('新規登録はこちら')
            )
          ],
        ),
      ),
    );
  }
}
