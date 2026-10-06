import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhome/cores/models/button_model.dart';

import '../../../cores/helper/http_response_helper.dart';
import '../../../cores/repositories/local_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HttpResponseHelper httpResponseHelper;
  final LocalRepository localRepo;
  final ImagePicker imagePicker;

  HomeBloc({
    required this.httpResponseHelper,
    required this.localRepo,
    required this.imagePicker,
  }) : super(HomeInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<ResetImage>(_onResetImage);
    on<RenameHomeEvent>(_onRenameButton);
    on<TurnOnHomeEvent>(_onTurnOnRelay);
    on<TurnOffHomeEvent>(_onTurnOffRelay);
    on<LoadRelayStatusEvent>(_onLoadRelayStatus);
  }

  Future<void> _onLoadRelayStatus(
    LoadRelayStatusEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final ip = await getIpAddress();
    final relayStatusRes = await httpResponseHelper.getRelayStatus(ip);
    final buttons = await getButtons();
    final connectionRes = await httpResponseHelper.getResponseStatus(ip);

    final error = connectionRes.fold((l) => l, (r) => null);
    if (error != null) {
      emit(HomeError(message: error.message));
      return;
    }
    final isConnected = connectionRes.fold((l) => false, (r) => r);

    relayStatusRes.fold(
      (error) {
        emit(HomeError(message: error.message));
      },
      (r) {
        emit(
          HomeLoaded(
            relayStates: r,
            isConnected: isConnected,
            ipAddress: ip,
            buttons: buttons,
          ),
        );
      },
    );
  }

  Future<void> _onTurnOnRelay(
    TurnOnHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    final current = state as HomeLoaded;
    final ip = await getIpAddress();
    final result = await httpResponseHelper.getResponseOn(event.index, ip);

    result.fold(
      (error) {
        emit(HomeError(message: error.message));
      },

      (_) {
        final updatedStates = List<bool>.from(current.relayStates);
        updatedStates[event.index] = true;
        emit(current.copyWith(relayStates: updatedStates));
      },
    );
  }

  Future<void> _onTurnOffRelay(
    TurnOffHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    final current = state as HomeLoaded;

    final ip = await getIpAddress();
    final result = await httpResponseHelper.getResponseOff(event.index, ip);

    result.fold(
      (error) {
        emit(HomeError(message: error.message));
      },

      (_) {
        final updatedStates = List<bool>.from(current.relayStates);
        updatedStates[event.index] = false;
        emit(current.copyWith(relayStates: updatedStates));
      },
    );
  }

  Future<void> _onPickImage(
    PickImageEvent event,

    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final pickedImage = event.pickedImage;

    event.button.copyWith(image: pickedImage);
    add(LoadRelayStatusEvent());
  }

  Future<void> _onResetImage(ResetImage event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final buttonModel = event.button;

    final result = await localRepo.updateButton(
      buttonModel.copyWith(image: ""),
    );

    final error = result.fold((l) => l, (r) => null);
    if (error != null) {
      emit(HomeError(message: error.message));
    }
    add(LoadRelayStatusEvent());
  }

  Future<void> _onRenameButton(
    RenameHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final buttonModel = event.button;

    final result = await localRepo.updateButton(
      buttonModel.copyWith(name: event.newName),
    );

    final error = result.fold((l) => l, (r) => null);
    if (error != null) {
      emit(HomeError(message: error.message));
    }
    add(LoadRelayStatusEvent());
  }

  Future<String> getIpAddress() async {
    final ipRes = await localRepo.getIpFromLocal();
    final error = ipRes.fold((l) => l, (r) => null);
    if (error != null) {
      return 'IP tidak ditemukan';
    }
    final ip = ipRes.fold((l) => null, (r) => r);
    return ip ?? 'IP tidak ditemukan';
  }

  Future<List<ButtonModel>> getButtons() async {
    final nameRes = await localRepo.getButtons();
    final error = nameRes.fold((l) => l, (r) => null);
    if (error != null) {
      return [];
    }
    final names = nameRes.fold((l) => null, (r) => r);
    return names ?? [];
  }
}
