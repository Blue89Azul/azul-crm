import 'package:azul_crm/core/di/modules/auth/auth_module.dart';
import 'package:azul_crm/core/log/app_logger.dart';
import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

Future<void> setupDependencies() async {
  // common
  injector.registerLazySingleton(() => AppLogger());
  injector.registerLazySingleton(() => AppLocalStorage());

  // Auth
  await initAuthModule(injector);

  // initAuthModule内でJWTRepositoryが生成されるため、後に実行
  injector.registerLazySingleton(
    () => AppApiClient(injector.get<JwtRepositoryInterface>()),
  );
}
