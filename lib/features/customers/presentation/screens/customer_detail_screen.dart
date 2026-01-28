import 'package:azul_crm/theme/app_color.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Detail', style: AppTextStyle.heading1),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Taro Yamada', style: AppTextStyle.heading2),
                Text(
                  'Sample Solution Inc. / Director',
                  style: AppTextStyle.bodyMedium,
                ),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 8.0),
                          Text('Phone', style: AppTextStyle.button),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          BorderSide(color: AppColor.primaryBlue),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.mail),
                          SizedBox(width: 8.0),
                          Text('E-mail', style: AppTextStyle.button),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Basic Information
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.grayLight,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  Text('Basic Information', style: AppTextStyle.heading3),
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                    height: 30.0,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status', style: AppTextStyle.bodyMedium),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.warmStatus,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Text(
                          'WARM',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Updated', style: AppTextStyle.bodyMedium),
                      Text('Sample Company', style: AppTextStyle.bodyMedium),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Last Contact', style: AppTextStyle.bodyMedium),
                      Text('Sample Company', style: AppTextStyle.bodyMedium),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Address', style: AppTextStyle.bodyMedium),
                      Text(
                        '〒100-0000 Tokyo, Shinbashi 1-1-1',
                        style: AppTextStyle.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab
            TabBar(
              tabs: [
                Tab(text: 'Related'),
                Tab(text: 'History'),
                Tab(text: 'Next Action'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Text('Related'),
                  Text('History'),
                  Text('Next Action'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
