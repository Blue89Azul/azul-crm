import 'package:azul_crm/core/di/modules/auth/auth_module.dart';
import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

Future<void> setupDependencies() async {
  // common
  injector.registerLazySingleton(() => AppLocalStorage());
  injector.registerSingleton(AppApiClient.instance);

  await initAuthModule(injector);
}