import 'package:azul_crm/core/init/blocs/events/app_init_event.dart';
import 'package:azul_crm/core/init/blocs/states/app_init_state.dart';
import 'package:azul_crm/core/init/domains/usecases/check_if_authenticated_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  final CheckIfAuthenticatedUsecase _checkIfAuthenticatedUsecase;
  static const int _minSplashDuration = 1000;

  AppInitBloc(this._checkIfAuthenticatedUsecase)
    : super(const AppInitState.checking()) {
    on<AppInitEvent>((events, emit) async {
      await events.when(
        appStarted: () => _appStarted(emit),
        authenticationChanged: () => _authenticationChanged(emit),
      );
    });

    add(AppInitEvent.appStarted());
  }

  /// アプリ起動時: 認証チェック + 最低1秒のスプラッシュ表示
  Future<void> _appStarted(emit) async {
    final startTime = DateTime.now();
    try {
      final isAuthenticated = await _checkIfAuthenticatedUsecase();
      
      // スプラッシュ画面を最低1秒表示
      await _ensureMinimumDuration(startTime);
      
      if (isAuthenticated) {
        emit(const AppInitState.ready(AppInitResult.authenticated));
      } else {
        emit(const AppInitState.ready(AppInitResult.unauthenticated));
      }
    } catch (e) {
      emit(const AppInitState.error('エラーが発生しました。'));
    }
  }

  /// ログイン/サインアップ後: 認証チェックのみ（即座に更新）
  Future<void> _authenticationChanged(emit) async {
    try {
      final isAuthenticated = await _checkIfAuthenticatedUsecase();
      
      if (isAuthenticated) {
        emit(const AppInitState.ready(AppInitResult.authenticated));
      } else {
        emit(const AppInitState.ready(AppInitResult.unauthenticated));
      }
    } catch (e) {
      emit(const AppInitState.error('エラーが発生しました。'));
    }
  }

  Future<void> _ensureMinimumDuration(DateTime start) async {
    final elapsed = DateTime.now().difference(start).inMilliseconds;
    final remainingDelay = _minSplashDuration - elapsed;
    if (remainingDelay > 0) {
      await Future.delayed(Duration(milliseconds: remainingDelay));
    }
  }
}
