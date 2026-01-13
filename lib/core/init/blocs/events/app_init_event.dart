import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_init_event.freezed.dart';

@freezed
sealed class AppInitEvent with _$AppInitEvent {
  const factory AppInitEvent.appStarted() = _AppStarted;
  const factory AppInitEvent.authenticationChanged() = _AuthenticationChanged;
}