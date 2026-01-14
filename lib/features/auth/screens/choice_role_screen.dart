import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:azul_crm/theme/app_color.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChoiceRoleScreen extends StatelessWidget {
  const ChoiceRoleScreen({super.key});

  Widget _titlePart() {
    return Column(
      children: [
        Text('Select Your Role', style: AppTextStyle.heading1),
        SizedBox(height: 8.0),
        Text(
          'Please choose the appropriate registration\nfor your role.',
          style: AppTextStyle.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _cardButton(
    String title, {
    required String description,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.grayLight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title, style: AppTextStyle.heading2),
              Text(description, style: AppTextStyle.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 85,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titlePart(),
            SizedBox(height: 8),
            Expanded(
              child: _cardButton(
                'Administrator',
                description:
                    'For users who create teams, manage all data, and configure system settings.',
                onTap: () {
                  context.pushNamed(AppRouteNames.signup, extra: AppRole.admin);
                },
              ),
            ),
            Expanded(
              child: _cardButton(
                'Team Member',
                description:
                    'For users who have an invitation code and perform assigned daily tasks only.',
                onTap: () {
                  context.pushNamed(
                    AppRouteNames.signup,
                    extra: AppRole.member,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
