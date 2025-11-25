import 'package:azul_crm/core/log/app_logger.dart';
import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:azul_crm/features/auth/blocs/signup/signup_bloc.dart';
import 'package:azul_crm/features/auth/data/repositories/auth_repository.dart';
import 'package:azul_crm/features/auth/data/repositories/auth_repository_interface.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository.dart';
import 'package:azul_crm/features/auth/domains/usecases/signup_usecase.dart';
import 'package:azul_crm/features/my_page/blocs/invitation_code_bloc.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository_interface.dart';
import 'package:azul_crm/features/my_page/domains/usecases/create_new_invitation_code_usecase.dart';
import 'package:azul_crm/features/my_page/domains/usecases/fetch_invitation_code_list_usecase.dart';

import 'package:get_it/get_it.dart';

part 'modules/auth_module.dart';
part 'modules/my_page_module.dart';

// Barrel Pattern に移行する

GetIt injector = GetIt.instance;

Future<void> setupDependencies() async {
  // common
  injector.registerLazySingleton(() => AppLogger());
  injector.registerLazySingleton(() => AppLocalStorage());

  // Auth
  await initAuthModule(injector);

  // MyPage
  await initMyPageModule(injector);

  // initAuthModule内でJWTRepositoryが生成されるため、後に実行
  injector.registerLazySingleton(
    () => AppApiClient(injector.get<JwtRepositoryInterface>()),
  );
}
