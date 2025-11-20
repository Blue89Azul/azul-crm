import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:azul_crm/features/my_page/domains/usecases/create_new_invitation_code_usecase.dart';
import 'package:azul_crm/features/my_page/domains/usecases/fetch_invitation_code_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/invitation_code_event.dart';
import 'states/invitation_code_state.dart';

class InvitationCodeBloc
    extends Bloc<InvitationCodeEvent, InvitationCodeState> {
  final FetchInvitationCodeListUseCase _fetchCodeListUseCase;
  final CreateNewInvitationCodeUseCase _createNewCodeUseCase;

  InvitationCodeBloc(this._fetchCodeListUseCase, this._createNewCodeUseCase)
    : super(InvitationCodeState()) {
    on<InvitationCodeListFetched>(_fetchCodeList);
    on<InvitationCodeCreated>(_createNewCode);
  }

  
  Future<void> _fetchCodeList(event, emit) async {
    emit(InvitationCodeState().copyWith(status: InvitationCodeStatus.loading));

    final result = await _fetchCodeListUseCase();

    result.fold(
      (String message) => emit(
        InvitationCodeState().copyWith(
          status: InvitationCodeStatus.loadFailure,
        ),
      ),
      (List<InvitationCode> invitationCodeList) => emit(
        InvitationCodeState().copyWith(
          status: InvitationCodeStatus.loaded,
          codes: invitationCodeList,
        ),
      ),
    );
  }

  Future<void> _createNewCode(InvitationCodeCreated event, emit) async {
    emit(InvitationCodeState().copyWith(status: InvitationCodeStatus.creating));

    final result = await _createNewCodeUseCase(event.grantedRole);

    result.fold(
      (String message) => emit(
        InvitationCodeState().copyWith(
          status: InvitationCodeStatus.createFailure,
        ),
      ),
      (InvitationCode newCode) {
        final currentCodeList = state.codes;
        currentCodeList.add(newCode);

        emit(
          InvitationCodeState().copyWith(
            status: InvitationCodeStatus.createSuccess,
            codes: currentCodeList,
          ),
        );
      },
    );
  }
}
