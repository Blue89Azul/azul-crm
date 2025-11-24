import 'package:azul_crm/shared/widgets/app_tag.dart';
import 'package:azul_crm/theme/app_color.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('This Month\'s result', style: AppTextStyle.heading2),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.grayLight,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Text('新規顧客', style: AppTextStyle.bodyLarge),
                    Text('100', style: AppTextStyle.heading3),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.grayLight,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Text('行動数', style: AppTextStyle.bodyLarge),
                    Text('100', style: AppTextStyle.heading3),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.grayLight,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Text('売り上げ', style: AppTextStyle.bodyLarge),
                    Text('¥1.2M', style: AppTextStyle.heading2),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Text('This Week\'s Plan', style: AppTextStyle.heading2),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.grayLight,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('新システム導入プロジェクト', style: AppTextStyle.heading3),
                      AppTag('予定中', backgroundColor: AppColor.hotStates),
                    ],
                  ),
                  Text('¥1.000.000', style: AppTextStyle.heading3),
                  Text('クローズ予定日: 2025/01/01', style: AppTextStyle.bodyMedium),
                  Text('関連顧客: Taro Yamada', style: AppTextStyle.bodyMedium),
                ]
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.grayLight,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                  children: [
                    Row(
                      children: [
                        Text('新システム導入プロジェクト', style: AppTextStyle.heading3),
                        AppTag('予定中', backgroundColor: AppColor.hotStates),
                      ],
                    ),
                    Text('¥1.000.000', style: AppTextStyle.heading3),
                    Text('クローズ予定日: 2025/01/01', style: AppTextStyle.bodyMedium),
                    Text('関連顧客: Taro Yamada', style: AppTextStyle.bodyMedium),
                  ]
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.grayLight,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                  children: [
                    Row(
                      children: [
                        Text('新システム導入プロジェクト', style: AppTextStyle.heading3),
                        AppTag('予定中', backgroundColor: AppColor.hotStates),
                      ],
                    ),
                    Text('¥1.000.000', style: AppTextStyle.heading3),
                    Text('クローズ予定日: 2025/01/01', style: AppTextStyle.bodyMedium),
                    Text('関連顧客: Taro Yamada', style: AppTextStyle.bodyMedium),
                  ]
              ),
            ),
          ],
        ),
      ],
    );
  }
}