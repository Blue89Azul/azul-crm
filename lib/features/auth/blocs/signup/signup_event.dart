part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String email;
  final String password;
  final AppRole role;

  SignupSubmitted(this.email, this.password, this.role);
}