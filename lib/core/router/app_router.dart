import 'dart:async';

import 'package:azul_crm/core/di/injector.dart';
import 'package:azul_crm/core/init/blocs/app_init_bloc.dart';
import 'package:azul_crm/core/init/blocs/states/app_init_state.dart';
import 'package:azul_crm/features/auth/screens/choice_role_screen.dart';
import 'package:azul_crm/features/auth/screens/login_screen.dart';
import 'package:azul_crm/features/auth/screens/signup_screen.dart';
import 'package:azul_crm/features/home/screens/home_screen.dart';
import 'package:azul_crm/features/my_page/screens/configuration_screen.dart';
import 'package:azul_crm/features/my_page/screens/invitation_code_screen.dart';
import 'package:azul_crm/features/welcome_screen.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutePaths.dashboard,
  refreshListenable: AppInitChangeNotifier(injector<AppInitBloc>().stream),
  redirect: (context, state) {
    final currentInitState = injector<AppInitBloc>().state;
    final currentLocation = state.matchedLocation;
    return currentInitState.when(
      checking: () => null,
      ready: (AppInitResult result) {
        final isPublic = AppRoutePaths.isPublicPath(currentLocation);
        final isAuthenticated = result == AppInitResult.authenticated;

        if (isAuthenticated && isPublic) {
          return AppRoutePaths.dashboard;
        }

        if (!isAuthenticated && !isPublic) {
          return AppRoutePaths.welcome;
        }

        return null;
      },
      error: (String message) => AppRoutePaths.welcome,
    );
  },
  routes: <RouteBase>[
    GoRoute(
      name: AppRouteNames.dashboard,
      path: AppRoutePaths.dashboard,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: AppRouteNames.welcome,
      path: AppRoutePaths.welcome,
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      name: AppRouteNames.signup,
      path: AppRoutePaths.signup,
      builder: (context, state) => SignupScreen(role: state.extra as AppRole),
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
      name: AppRouteNames.configuration,
      path: AppRoutePaths.configuration,
      builder: (context, state) => ConfigurationScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.invitationCode,
      name: AppRouteNames.invitationCode,
      builder: (context, state) => InvitationCodeScreen(),
    )
  ],
);

class AppInitChangeNotifier extends ChangeNotifier {
  late final StreamSubscription _sub;

  AppInitChangeNotifier(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

/// Route Names
abstract class AppRouteNames {
  static const String choiceRole = 'choice_role';
  static const String dashboard = 'home';
  static const String welcome = 'welcome';
  static const String signup = 'signup';
  static const String login = 'login';
  static const String configuration = 'configuration';
  static const String invitationCode = 'invitation_code';
}

/// Route Paths
abstract class AppRoutePaths {
  static const String choiceRole = '/choice_role';
  static const String dashboard = '/home';
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String configuration = '/configuration';
  static const String invitationCode = '/configuration/invitation_code';
  
  static bool isPublicPath(String path) {
    return path == welcome ||
        path == signup ||
        path == login ||
        path == choiceRole;
  }
}
