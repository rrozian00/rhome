import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/features/auth/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authRepo = AuthRepository();

  LoginBloc() : super(LoginInitial()) {
    on<DoLogin>(_onDoLogin);
  }

  Future<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await authRepo.login(event.email, event.password);
    emit(LoginSuccess());
  }
}
