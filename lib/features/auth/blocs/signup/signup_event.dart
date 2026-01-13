part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String email;
  final String password;
  final AppRole role;
  final String code;
  final String account;

  SignupSubmitted(this.email, this.password, this.account, this.role, this.code);
}