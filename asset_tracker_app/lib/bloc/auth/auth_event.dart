import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUpRequested(
      this.email, this.password, this.firstName, this.lastName);

  @override
  List<Object> get props => [email, password, firstName, lastName];
}

class SignOutRequested extends AuthEvent {}
