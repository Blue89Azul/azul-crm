import 'package:azul_crm/core/di/injector.dart';
import 'package:azul_crm/features/my_page/blocs/events/invitation_code_event.dart';
import 'package:azul_crm/features/my_page/blocs/invitation_code_bloc.dart';
import 'package:azul_crm/features/my_page/blocs/states/invitation_code_state.dart';
import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:azul_crm/shared/widgets/app_tag.dart';
import 'package:azul_crm/shared/widgets/screen_padding.dart';
import 'package:azul_crm/theme/app_color.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// エンドポイント
/// 1. 画面遷移時のinvitation_codesのリスト取得 GET: /invitation_codes
/// 2. リストの新規発行 POST: /invitation_codes
/// 3. ステータスの更新, コピーの実行 PUT: /invitation_codes/{id}
/// 2.については、1.でフェッチしてるコレクションに対して、どんどん追加していくイメージ

class InvitationCodeScreen extends StatelessWidget {
  const InvitationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitation Code', style: AppTextStyle.heading1),
      ),
      body: BlocProvider(
        lazy: false,
        create: (BuildContext context) =>
            injector<InvitationCodeBloc>()..add(InvitationCodeListFetched()),
        child: ScreenPadding(child: _InvitationCodeView()),
      ),
    );
  }
}

class _InvitationCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCodeBloc, InvitationCodeState>(
      builder: (BuildContext context, InvitationCodeState state) {
        final isLoading =
            state.status == InvitationCodeStatus.loading ||
            state.status == InvitationCodeStatus.creating;
        return Column(
          children: [
            SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _InvitationCodeInfoCounter(
                    title: 'Logged In',
                    count: 0,
                  ),
                ),
                Expanded(
                  child: _InvitationCodeInfoCounter(
                    title: 'Inviting',
                    count: 0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),

            // 発行コードリスト
            if (isLoading) Center(child: CircularProgressIndicator()),
            if (!isLoading)
              Expanded(
                child: ListView(
                  children: state.codes.map((InvitationCode code) {
                    return _InvitationCodeCard(
                      code: code.code,
                      issueDate: code.createdAt.toString(),
                      status: code.redeemedAt != null
                          ? "logged_in"
                          : "inviting",
                    );
                  }).toList(),
                ),
              ),

            // 新規発行ボタン
            _CreateNewCodeButton(),
          ],
        );
      },
    );
  }
}

// ----- Components -----

class _CreateNewCodeButton extends StatelessWidget {
  const _CreateNewCodeButton();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InvitationCodeBloc>();
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: FilledButton(
        onPressed: () =>
            bloc.add(InvitationCodeCreated(grantedRole: AppRole.member)),
        child: Text(
          'Create a Code',
          style: AppTextStyle.heading3.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class _InvitationCodeInfoCounter extends StatelessWidget {
  final String title;
  final int count;

  const _InvitationCodeInfoCounter({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(title, style: AppTextStyle.heading3),
          Text(count.toString(), style: AppTextStyle.heading2),
        ],
      ),
    );
  }
}

class _InvitationCodeCard extends StatelessWidget {
  final String code;
  final String issueDate;
  final String status;

  const _InvitationCodeCard({
    required this.code,
    required this.issueDate,
    required this.status,
  });

  Color get statusColor {
    if (status == 'loggedIn') {
      return AppColor.success;
    }
    return AppColor.warning;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColor.grayLight),
          left: BorderSide(color: AppColor.warning, width: 4),
          right: BorderSide(color: AppColor.grayLight),
          bottom: BorderSide(color: AppColor.grayLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // バッジ
                AppTag(status, backgroundColor: statusColor),

                // コード名
                Text(
                  code,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // 発行日時
                Text('Issue date: $issueDate', style: AppTextStyle.bodyMedium),
              ],
            ),
          ),
          FilledButton(onPressed: () {}, child: const Text('Copy')),
        ],
      ),
    );
  }
}
