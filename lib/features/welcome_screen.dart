import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/shared/widgets/app_toast.dart';
import 'package:azul_crm/shared/widgets/screen_padding.dart';
import 'package:azul_crm/theme/app_color.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = GoRouterState.of(context).uri;
      final showLogoutToast = uri.queryParameters['showLogoutToast'];
      
      if (showLogoutToast == 'true') {
        AppToast.showSuccess('ログアウトしました');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColor.primaryBlue,
      child: SafeArea(
        child: ScreenPadding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('AZUL CRM', style: AppTextStyle.title),
              Text(
                'Manage your sales activities seamlessly, anywhere.',
                style: AppTextStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              FilledButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    Size(double.infinity, 42),
                  ),
                  backgroundColor: WidgetStateProperty.all(AppColor.grayLight),
                  foregroundColor: WidgetStateProperty.all(
                    AppColor.primaryBlue,
                  ),
                ),
                onPressed: () {
                  context.pushNamed(AppRouteNames.choiceRole);
                },
                child: Text('SIGN UP'),
              ),
              SizedBox(height: 12),
              FilledButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    Size(double.infinity, 42),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    AppColor.primaryDark,
                  ),
                  foregroundColor: WidgetStateProperty.all(AppColor.grayLight),
                ),
                onPressed: () {
                  context.pushNamed(AppRouteNames.login);
                },
                child: Text('LOG IN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
