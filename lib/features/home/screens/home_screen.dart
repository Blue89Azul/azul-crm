import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/shared/user/logged_in_user.dart';
import 'package:azul_crm/shared/widgets/screen_padding.dart';
import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final LoggedInUser _loggedInUser = LoggedInUser();
  final StatefulNavigationShell navigationShell;

  void onTapAppBarMenu(BuildContext context) {
    context.pushNamed(AppRouteNames.configuration);
  }

  HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return _HomeView(_loggedInUser, navigationShell, onTapAppBarMenu);
  }
}

class _HomeView extends StatelessWidget {
  late final LoggedInUser _loggedInUser;
  late final StatefulNavigationShell _navigationShell;
  late final Function(BuildContext context) _onTapAppBarMenu;

  _HomeView(
    LoggedInUser loggedInUser,
    StatefulNavigationShell navigationShell,
    Function(BuildContext context) onTapAppBarMenu,
  ) {
    _loggedInUser = loggedInUser;
    _navigationShell = navigationShell;
    _onTapAppBarMenu = onTapAppBarMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: AppTextStyle.heading1),
        leading: IconButton(
          onPressed: _onTapAppBarMenu(context),
          icon: Icon(Icons.menu),
        ),
        actions: [
          if (_loggedInUser.appRole != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _roleIcon(_loggedInUser),
            ),
        ],
      ),
      body: ScreenPadding(child: _navigationShell),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationShell.currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black26,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: AppRouteNames.dashboard,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: AppRouteNames.customer,
          ),
        ],
      ),
    );
  }
}

Widget _roleIcon(LoggedInUser loggedInUser) {
  return Row(
    children: [
      Icon(
        loggedInUser.isAdmin ? Icons.admin_panel_settings : Icons.person,
        color: loggedInUser.isAdmin ? Colors.amber : Colors.blue,
      ),
      SizedBox(width: 8),
      Text(
        loggedInUser.getRoleName(),
        style: AppTextStyle.bodyMedium.copyWith(
          color: loggedInUser.isAdmin ? Colors.amber : Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
