import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/cores/app/app_version.dart';
import 'package:rhome/features/home/data/remote/home_repository.dart';
import 'package:rhome/features/setting/repositories/setting_repo.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final settingRepo = SettingRepo();
  final homeRepo = HomeRepository();

  SettingBloc() : super(SettingLoaded(appVersion: "", ipAdress: "")) {
    on<GetAppVersion>(_onGetAppVersion);
    on<SaveIpAddress>(_onSaveIpAddress);
  }

  void _onGetAppVersion(GetAppVersion event, Emitter<SettingState> emit) async {
    emit(SettingLoading());
    try {
      final version = await getAppVersion();
      final ip = await settingRepo.getIpAll();
      if (ip != null && ip != "") {
        emit(SettingLoaded(appVersion: version, ipAdress: ip));
      }
    } catch (e) {
      emit(SettingError(message: e.toString()));
    }
  }

  void _onSaveIpAddress(SaveIpAddress event, Emitter<SettingState> emit) async {
    emit(SettingLoading());
    await settingRepo.updateIpAddress(event.ipAddress);
    final currentState = state;
    if (currentState is SettingLoaded) {
      emit(currentState.copyWith(ipAddress: event.ipAddress));
    }
  }
}
