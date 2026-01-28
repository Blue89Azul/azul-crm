import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/shared/user/logged_in_user.dart';
import 'package:azul_crm/features/home/screens/dashboard_view.dart';
import 'package:azul_crm/shared/widgets/screen_padding.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  final LoggedInUser _loggedInUser = LoggedInUser();

  void _onTapBottomNavigation(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: AppTextStyle.heading1),
        leading: IconButton(
          onPressed: () {
            context.pushNamed(AppRouteNames.configuration);
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          if (_loggedInUser.appRole != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    _loggedInUser.isAdmin 
                        ? Icons.admin_panel_settings 
                        : Icons.person,
                    color: _loggedInUser.isAdmin 
                        ? Colors.amber 
                        : Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    _loggedInUser.isAdmin ? 'Admin' : 'Member',
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: _loggedInUser.isAdmin 
                          ? Colors.amber 
                          : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: ScreenPadding(
        child: <Widget>[
          DashBoardView(),
          Center(child: Text('CustomerPage')),
          Center(child: Text('CompanyPage')),
          Center(child: Text('ActionsPage')),
        ][_currentPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onTapBottomNavigation,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black26,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_rounded),
            label: 'Companies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: 'Actions',
          ),
        ],
      ),
    );
  }
}
