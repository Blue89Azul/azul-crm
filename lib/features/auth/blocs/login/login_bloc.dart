import 'package:azul_crm/features/auth/blocs/login/events/login_event.dart';
import 'package:azul_crm/features/auth/blocs/login/states/login_state.dart';
import 'package:azul_crm/features/auth/domains/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginState.initial()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(event, emit) async {
    emit(LoginState.loading());

    final result = await _loginUseCase(event.email, event.password);

    result.fold(
      (message) => emit(LoginState.failure(message)),
      (_) => emit(LoginState.success()),
    );
  }
}
