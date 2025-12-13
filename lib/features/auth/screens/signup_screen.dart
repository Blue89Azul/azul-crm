import 'package:azul_crm/core/di/injector.dart';
import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/features/auth/blocs/signup/signup_bloc.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:azul_crm/shared/widgets/app_toast.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<SignupBloc>(),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final invitationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration', style: AppTextStyle.heading1)),
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            context.goNamed(AppRouteNames.dashboard);
            return;
          }
          if (state is SignupFailure) {
            AppToast.showError(state.message);
            return;
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Mail Address'),
                  controller: emailController,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(labelText: 'Invitation Code'),
                  controller: invitationController,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupBloc>().add(
                      SignupSubmitted(
                        emailController.text,
                        passwordController.text,
                        AppRole.admin
                      ),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
