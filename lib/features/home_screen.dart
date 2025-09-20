import 'package:azul_crm/features/dashboard/screens/dashboard_view.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  void _onTapBottomNavigation(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashbord', style: AppTextStyle.heading1,)),
      body: <Widget>[
        DashBoardView(),
        Center(child: Text('CustomerPage')),
        Center(child: Text('CompanyPage')),
        Center(child: Text('ActionsPage')),
      ][_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onTapBottomNavigation,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black26,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'ダッシュボード',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: '顧客',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_rounded),
            label: '会社',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: '行動',
          ),
        ],
      ),
    );
  }
}
