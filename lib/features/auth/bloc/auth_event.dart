part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

// ログインイベント
class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  LogInRequested(this.email, this.password);
}

// サインアップイベント
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);
}

// ログアウトイベント
class LogoutRequested extends AuthEvent {

}