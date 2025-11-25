part of '../injector.dart';

Future<void> initMyPageModule(GetIt injector) async {
  // Repository
  injector.registerLazySingleton<InvitationCodeRepositoryInterface>(
    () => InvitationCodeRepository(injector.get<AppApiClient>()),
  );

  // UseCase
  injector.registerLazySingleton(
    () => FetchInvitationCodeListUseCase(injector()),
  );
  injector.registerLazySingleton(
    () => CreateNewInvitationCodeUseCase(injector()),
  );

  // Bloc
  injector.registerLazySingleton(
    () => InvitationCodeBloc(injector(), injector()),
  );
}
