import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../cores/app/app_version.dart';
import '../../repositories/local_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final LocalRepository localRepo;

  SettingBloc({required this.localRepo}) : super(SettingInitial()) {
    on<GetSettings>(_onGetSettings);
    on<UpdateIpAddress>(_onUpdateIpAddress);
  }

  void _onGetSettings(GetSettings event, Emitter<SettingState> emit) async {
    emit(SettingLoading());
    final version = await getAppVersion();
    final resIp = await localRepo.getIpFromLocal();
    final ipAddress = resIp.fold((l) => "", (r) => r);
    emit(SettingLoaded(appVersion: version, ipAdress: ipAddress));
  }

  Future<void> _onUpdateIpAddress(
    UpdateIpAddress event,
    Emitter<SettingState> emit,
  ) async {
    final currentState = state as SettingLoaded;

    emit(SettingLoading());
    final currentIp = event.ipAddress;
    final res = await localRepo.saveIpToLocal(currentIp);
    res.fold(
      (l) => emit(SettingError(message: l.message)),
      (r) => emit(currentState.copyWith(ipAddress: currentIp)),
    );
  }
}
