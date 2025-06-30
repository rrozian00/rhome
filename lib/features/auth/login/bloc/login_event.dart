part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class DoLogin extends LoginEvent {
  final String email;
  final String password;

  const DoLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class CheckAuth extends LoginEvent {}

// final class DoLogout extends LoginEvent {}
