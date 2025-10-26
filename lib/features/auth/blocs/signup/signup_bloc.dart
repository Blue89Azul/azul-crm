import 'package:azul_crm/features/auth/domains/usecases/signup_usecase.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_state.dart';
part 'signup_event.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase _signupUseCase;

  SignupBloc(this._signupUseCase) : super(SignupInitial()) {
    on<SignupSubmitted>((event, emit) async {
      emit(SignupLoading());

      final result = await _signupUseCase.handle(event.email, event.password, AppRole.admin);

      result.fold(
          (errorMessage) => emit(SignupFailure(errorMessage)),
          (_) => emit(SignupSuccess()),
      );
    });
  }
}