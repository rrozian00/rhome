part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {
  final String message;

  const LoginFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserLogged extends LoginState {}

final class UserLogout extends LoginState {}
