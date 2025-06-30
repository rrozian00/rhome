import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/features/auth/repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;

  RegisterBloc({required this.authRepo}) : super(RegisterInitial()) {
    on<DoRegister>(_onDoRegister);
  }

  Future<void> _onDoRegister(
    DoRegister event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await authRepo.register(
      email: event.email,
      password: event.password,
      name: event.name,
    );
    result.fold(
      (l) {
        emit(RegisterFailed(message: l.message));
      },
      (r) {
        emit(RegisterSuccess());
      },
    );
  }
}
