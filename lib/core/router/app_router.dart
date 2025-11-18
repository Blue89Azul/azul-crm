import 'package:azul_crm/features/auth/screens/choice_role_screen.dart';
import 'package:azul_crm/features/auth/screens/login_screen.dart';
import 'package:azul_crm/features/auth/screens/signup_screen.dart';
import 'package:azul_crm/features/home_screen.dart';
import 'package:azul_crm/features/my_page/presentation/screens/permission_management_screen.dart';
import 'package:azul_crm/features/welcome_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutePaths.welcome,
  routes: <RouteBase>[
    GoRoute(
      name: AppRouteNames.dashboard,
      path: AppRoutePaths.dashboard,
      builder: (context, state) => DashBoardView(),
    ),
    GoRoute(
      name: AppRouteNames.welcome,
      path: AppRoutePaths.welcome,
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      name: AppRouteNames.signup,
      path: AppRoutePaths.signup,
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(
      name: AppRouteNames.login,
      path: AppRoutePaths.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: AppRouteNames.choiceRole,
      path: AppRoutePaths.choiceRole,
      builder: (context, state) => ChoiceRoleScreen(),
    ),
    GoRoute(
      name: AppRouteNames.myPage,
      path: AppRoutePaths.myPage,
      builder: (context, state) => PermissionManagementScreen(),
    )
  ]
);



/// Route Names
abstract class AppRouteNames {
  static const String choiceRole = 'choice_role';
  static const String dashboard  = 'dashboard';
  static const String welcome    = 'welcome';
  static const String signup     = 'signup';
  static const String login      = 'login';
  static const String myPage     = 'myPage';
}

/// Route Paths
abstract class AppRoutePaths {
  static const String choiceRole = '/choice_role';
  static const String dashboard  = '/dashboard';
  static const String welcome    = '/welcome';
  static const String signup     = '/signup';
  static const String login      = '/login';
  static const String myPage     = '/my_page';
}