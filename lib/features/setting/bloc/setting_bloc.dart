import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/cores/app/app_version.dart';
import 'package:rhome/features/auth/models/user_model.dart';
import 'package:rhome/features/auth/repositories/auth_repository.dart';
import 'package:rhome/features/home/data/remote/home_repository.dart';
import 'package:rhome/features/setting/repositories/setting_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepository settingRepo;
  final HomeRepository homeRepo;
  final AuthRepository authRepo;

  SettingBloc({
    required this.settingRepo,
    required this.homeRepo,
    required this.authRepo,
  }) : super(SettingInitial()) {
    on<GetAppVersion>(_onGetAppVersion);
    on<UpdateIpAddress>(_onUpdateIpAddress);
    on<DoLogout>(_onDoLogout);
  }

  void _onGetAppVersion(GetAppVersion event, Emitter<SettingState> emit) async {
    emit(SettingLoading());
    try {
      final version = await getAppVersion();
      final result = await settingRepo.getProfile();
      final userData = result.getOrElse(
        () => throw Exception('User Tidak ditemukan'),
      );

      final ip = await settingRepo.getIpAll();

      emit(
        SettingLoaded(
          isLogout: false,
          appVersion: version,
          ipAdress: ip ?? 'IP Adress not found.',
          user: userData,
        ),
      );
    } catch (e) {
      emit(SettingError(message: e.toString()));
    }
  }

  Future<void> _onUpdateIpAddress(
    UpdateIpAddress event,
    Emitter<SettingState> emit,
  ) async {
    emit(SettingLoading());
    await settingRepo.updateIpAddress(event.ipAddress);
    final currentState = state;
    if (currentState is SettingLoaded) {
      emit(currentState.copyWith(ipAddress: event.ipAddress));
    }
  }

  Future<void> _onDoLogout(DoLogout event, Emitter<SettingState> emit) async {
    emit(SettingLoading());
    await Future.delayed(Duration(seconds: 1));
    await authRepo.logout();
    emit(
      SettingLoaded(
        appVersion: '',
        ipAdress: '',
        user: UserModel(),
        isLogout: true,
      ),
    );
  }
}
