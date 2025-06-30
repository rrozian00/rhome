import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/features/auth/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginInitial()) {
    on<DoLogin>(_onDoLogin);
    on<CheckAuth>(_onCheckAuth);
    // on<DoLogout>(_onDoLogout);
  }

  Future<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await authRepo.login(event.email, event.password);
    result.fold(
      (l) {
        emit(LoginFailed(message: l.message));
      },
      (r) {
        emit(LoginSuccess());
      },
    );
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<LoginState> emit) async {
    final user = authRepo.getCurrentUser();
    if (user != null) {
      emit(UserLogged());
    } else {
      emit(UserLogout());
    }
  }

  // Future<void> _onDoLogout(DoLogout event, Emitter<LoginState> emit) async {
  //   emit(LoginLoading());
  //   await Future.delayed(Duration(seconds: 1));
  //   await authRepo.logout();
  //   emit(UserLogout());
  // }
}
