import 'package:azul_crm/core/di/injector.dart';
import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/features/auth/blocs/login/events/login_event.dart';
import 'package:azul_crm/features/auth/blocs/login/login_bloc.dart';
import 'package:azul_crm/features/auth/blocs/login/states/login_state.dart';
import 'package:azul_crm/shared/widgets/app_toast.dart';
import 'package:azul_crm/shared/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginEvent.submitted(_emailController.text, _passwordController.text),
      );
    }
  }

  void _toSignupScreen() {
    Navigator.pushNamed(context, AppRoutePaths.signup);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          state.when(
            initial: () => null,
            loading: () => null,
            success: () {
              context.goNamed(AppRouteNames.dashboard);
            },
            failure: (message) {
              AppToast.showError(message);
            },
          );
        },
        builder: (context, state) {
          return _LoginView(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            onLoginPressed: () => _login(context),
            onSignupPressed: _toSignupScreen,
            isLoading: state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            ),
          );
        },
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;
  final VoidCallback onSignupPressed;
  final bool isLoading;

  const _LoginView({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
    required this.onSignupPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ScreenPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'example@example.com',
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスを入力してください';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'azul-crm0123',
                    ),
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: isLoading ? null : onLoginPressed,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                ],
              ),
            ),
            TextButton(onPressed: onSignupPressed, child: Text('新規登録はこちら')),
          ],
        ),
      ),
    );
  }
}
