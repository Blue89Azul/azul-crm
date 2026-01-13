import 'package:azul_crm/features/negotiations/screens/negotiation_detail_screen.dart';
import 'package:azul_crm/theme/app_color.dart';
import 'package:flutter/material.dart';

// 顧客と会社は同じスクリーンにする
// CrmDomainInfoListScreen
// 商談は別の概念になるため共通化は避ける
/// ここでBlocが使えそう
/// Initial (ローカルでどちらが表示されていたか保持して、表示)
/// Loading (データフェッチ)
/// Changed ()

class SwitchDomainListScreen extends StatefulWidget {
  const SwitchDomainListScreen({super.key});

  @override
  State<SwitchDomainListScreen> createState() => _SwitchDomainListScreenState();
}

class _SwitchDomainListScreenState extends State<SwitchDomainListScreen> {
  bool _isCustomer = true;
  @override
  Widget build(BuildContext context) {
    Icon currentListIcon = _isCustomer
        ? Icon(Icons.people_alt)
        : Icon(Icons.business);
    Text title = _isCustomer ? Text('顧客') : Text('会社');
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isCustomer = !_isCustomer;
              });
            },
            icon: currentListIcon,
          ),
        ],
      ),
      body: Column(
        children: [
          // 顧客
          AppListItem(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 左揃えにする
                  children: [
                    Text('ABC株式会社'),
                    const SizedBox(height: 4.0),
                    Text(
                      '山田 太郎',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text('開発部 係長'),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [Icon(Icons.check_box), Icon(Icons.edit_note)],
                    ),
                    Text(
                      '更新日:2025/01/01',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            statusColor: AppColor.coldStatus,
          ),

          // 会社
          AppListItem(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('IT'),
                    const SizedBox(height: 4.0),
                    Text(
                      'ABC株式会社',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text('〒100-0000', style: TextStyle(fontSize: 12),),
                    Text('東京都渋谷区神宮前1-1-1ABCビル2F', style: TextStyle(fontSize: 12))
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [Icon(Icons.check_box), Icon(Icons.edit_note)],
                    ),
                    Text(
                      '更新日:2025/01/01',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            statusColor: AppColor.warmStatus,
          ),

          // 商談
          Container(
            color: Colors.black12,
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text('Negotiation Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
                // description
                Text(
                  'この商談に関する説明を記載しています。この商談に関する説明を記載しています。この商談に関する説明を記載しています。',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),

                // staus bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('進行中'),
                    LinearProgressIndicator(
                      backgroundColor: Colors.white70,
                      value: 0.4,
                    ),
                  ],
                ),

                Row(
                  children: [
                    // deadline
                    Column(
                      children: [
                        Text('deadLine'),
                        Text('2027/01/01'),
                      ],
                    ),

                    // price
                    Row(
                      children: [
                        Icon(Icons.money),
                        Text('1.000.000')
                      ],
                    ),

                    // 担当者
                    // タップで担当者名が確認できる
                    Row(
                      children: [
                        Icon(Icons.person),
                        Text('×2')
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Container > child を 引数でもらう。
class AppListItem extends StatelessWidget {
  final Widget _content;
  final Color _statusColor;

  const AppListItem({super.key, required content, required statusColor})
      : _content = content,
        _statusColor = statusColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NegotiationDetailScreen(),
            )
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: _buildSideBar(_statusColor),
        child: _content,
      ),
    );
  }

  BoxDecoration _buildSideBar(Color statusColor) {
    return BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      border: Border(left: BorderSide(color: statusColor, width: 10.0,)),
    );
  }
}
