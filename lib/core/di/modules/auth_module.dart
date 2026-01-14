part of '../injector.dart';


Future<void> initAuthModule(GetIt injector) async {
  // Repositories
  injector.registerLazySingleton<AuthRepositoryInterface>(
    () => AuthRepository(injector(), injector(), injector()),
  );

  injector.registerLazySingleton<JwtRepositoryInterface>(
    () => JwtRepository(injector()),
  );

  // UseCases
  injector.registerFactory(() => SignupUseCase(injector(), injector()));
  injector.registerFactory(() => LoginUseCase(injector(), injector()));
  injector.registerFactory(() => LogoutUseCase(injector(), injector()));

  // Blocs
  injector.registerFactory(() => SignupBloc(injector()));
  injector.registerFactory(() => LoginBloc(injector()));
}
