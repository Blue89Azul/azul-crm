import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_init_state.freezed.dart';

@freezed
sealed class AppInitState with _$AppInitState {
  const factory AppInitState.checking() = _Checking;

  const factory AppInitState.ready(AppInitResult result) = _Ready;

  const factory AppInitState.error(String message) = _Error;
}

enum AppInitResult { authenticated, unauthenticated, maintenance, forceUpdate }
