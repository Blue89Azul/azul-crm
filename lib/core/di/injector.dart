import 'package:azul_crm/core/init/blocs/app_init_bloc.dart';
import 'package:azul_crm/core/init/domains/usecases/check_if_authenticated_usecase.dart';
import 'package:azul_crm/core/log/app_logger.dart';
import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:azul_crm/features/auth/blocs/login/login_bloc.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:azul_crm/features/auth/blocs/signup/signup_bloc.dart';
import 'package:azul_crm/features/auth/data/repositories/auth_repository.dart';
import 'package:azul_crm/features/auth/data/repositories/auth_repository_interface.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository.dart';
import 'package:azul_crm/features/auth/domains/services/jwt_token_decoder.dart';
import 'package:azul_crm/features/auth/domains/usecases/login_usecase.dart';
import 'package:azul_crm/features/auth/domains/usecases/logout_usecase.dart';
import 'package:azul_crm/features/auth/domains/usecases/signup_usecase.dart';
import 'package:azul_crm/features/my_page/blocs/invitation_code_bloc.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository_interface.dart';
import 'package:azul_crm/features/my_page/domains/usecases/create_new_invitation_code_usecase.dart';
import 'package:azul_crm/features/my_page/domains/usecases/fetch_invitation_code_list_usecase.dart';

import 'package:get_it/get_it.dart';

part 'modules/auth_module.dart';

part 'modules/my_page_module.dart';

GetIt injector = GetIt.instance;

Future<void> setupDependencies() async {
  // common
  injector.registerLazySingleton(() => AppLogger());
  injector.registerLazySingleton(() => AppLocalStorage());

  // Auth
  await initAuthModule(injector);

  injector.registerLazySingleton(
    () => AppApiClient(
      injector.get<JwtRepositoryInterface>(),
      injector.get<AppLocalStorage>(),
    ),
  );

  // MyPage
  await initMyPageModule(injector);

  injector.registerLazySingleton(() => CheckIfAuthenticatedUsecase(injector()));
  injector.registerLazySingleton(() => AppInitBloc(injector()));
}
