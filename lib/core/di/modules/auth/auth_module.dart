import 'package:azul_crm/features/auth/blocs/signup/signup_bloc.dart';
import 'package:azul_crm/features/auth/data/repositories/auth_repository.dart';
import 'package:azul_crm/features/auth/data/repositories/auth_repository_interface.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:azul_crm/features/auth/domains/usecases/signup_usecase.dart';
import 'package:get_it/get_it.dart';


Future<void> initAuthModule(GetIt injector) async {
  // Repositories
  injector.registerLazySingleton<AuthRepositoryInterface>(() => AuthRepository(injector()));
  injector.registerLazySingleton<JwtRepositoryInterface>(() => JwtRepository(injector()));

  // UseCases
  injector.registerFactory(() => SignupUseCase(injector(), injector()));

  // Blocs
  injector.registerFactory(() => SignupBloc(injector()));
}