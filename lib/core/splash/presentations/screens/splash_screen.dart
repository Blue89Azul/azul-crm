import 'package:azul_crm/theme/app_color.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: AppColor.primaryBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('AZUL CRM', style: AppTextStyle.title),
          Text(
            'Blueprints for Business Growth',
            style: AppTextStyle.bodyLarge.copyWith(color: AppColor.grayLight),
          ),
        ],
      ),
    );
  }
}
