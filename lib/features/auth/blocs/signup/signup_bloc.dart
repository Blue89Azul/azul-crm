import 'package:azul_crm/core/di/injector.dart';
import 'package:azul_crm/core/init/blocs/app_init_bloc.dart';
import 'package:azul_crm/core/init/blocs/events/app_init_event.dart';
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

      final result = await _signupUseCase(
        event.email,
        event.password,
        event.account,
        event.role,
        event.code,
      );

      result.fold(
        (errorMessage) {
          emit(SignupFailure(errorMessage));
        },
        (result) {
          final user = result;
          user.updateLoggedInUser();

          emit(SignupSuccess());
          injector<AppInitBloc>().add(AppInitEvent.authenticationChanged());
        },
      );
    });
  }
}
