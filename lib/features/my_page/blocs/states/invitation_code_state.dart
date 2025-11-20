import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_code_state.freezed.dart';


@freezed
abstract class InvitationCodeState with _$InvitationCodeState {
  const factory InvitationCodeState({
    @Default(InvitationCodeStatus.initial) InvitationCodeStatus status,
    @Default([]) List<InvitationCode> codes,
    String? errorMessage,
  }) = _InvitationCodeState;
}

enum InvitationCodeStatus {
  initial,
  loading,
  loaded,
  loadFailure,
  creating,
  createSuccess,
  createFailure,
}