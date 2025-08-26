import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azul_crm/features/auth/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<LogInRequested>(_requestLogin);
    on<SignUpRequested>(_requestSignup);
    on<LogoutRequested>(_requestLogout);
  }

  void _requestLogin(LogInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated());
    } catch (e) {
      emit(Unauthenticated(e.toString()));
      emit(AuthInitial());
    }
  }

  void _requestSignup(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated());
    } catch (e) {
      emit(Unauthenticated(e.toString()));
      emit(AuthInitial());
    }
  }

  void _requestLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(Unauthenticated('the user executed logout.'));
    emit(AuthInitial());
  }
}
