import 'package:azul_crm/core/di/injector.dart';
import 'package:azul_crm/core/init/blocs/app_init_bloc.dart';
import 'package:azul_crm/core/init/blocs/states/app_init_state.dart';
import 'package:azul_crm/core/router/app_router.dart';
import 'package:azul_crm/core/splash/presentations/screens/splash_screen.dart';
import 'package:azul_crm/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AZUL CRM',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        return BlocBuilder<AppInitBloc, AppInitState>(
          bloc: injector<AppInitBloc>(),
          builder: (context, state) {
            return state.maybeWhen(
              checking: () => const SplashScreen(),
              orElse: () => child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
