part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {

}

// 認証前
class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

// 認証中
class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

// 認証完了
class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// 未認証
class Unauthenticated extends AuthState {
  final String? reason;

  Unauthenticated(this.reason);

  @override
  List<Object?> get props => [reason];
}