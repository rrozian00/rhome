import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/image_repository.dart';
import '../../repositories/local_repository.dart';
import '../../repositories/relay_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RelayRepository relayRepo;
  final LocalRepository localRepo;
  final ImageRepository imageRepo;

  HomeBloc({
    required this.relayRepo,

    required this.localRepo,
    required this.imageRepo,
  }) : super(HomeLoaded.initial()) {
    on<PickImageEvent>(_onPickImage);

    on<ResetImage>(_onResetImage);

    on<RenameHomeEvent>(_onRenameRelay);

    on<TurnOnHomeEvent>(_onTurnOnRelay);

    on<TurnOffHomeEvent>(_onTurnOffRelay);
    on<LoadRelayStatusEvent>(_onLoadRelayStatus);
  }

  Future<void> _onLoadRelayStatus(
    LoadRelayStatusEvent event,
    Emitter<HomeState> emit,
  ) async {
    final ip = await getIpAddress();
    final result = await relayRepo.getRelayStatus(ip);
    final relayNames = await getRelayNames();
    final imagePaths = await getImages();

    emit(HomeLoading());

    result.fold(
      (error) {
        emit(HomeError(message: error.message));
      },
      (r) {
        emit(
          HomeLoaded(
            relayStates: r,
            relayNames: relayNames,
            isConnected: true,
            ipAddress: ip,
            imagePath: imagePaths,
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
    final result = await relayRepo.getResponseOn(event.index, ip);

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
    final result = await relayRepo.getResponseOff(event.index, ip);

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
    final current = state as HomeLoaded;

    emit(HomeLoading());

    final result = await imageRepo.setImage(event.index);

    final error = result.fold((l) => l, (r) => null);
    if (error != null) {
      emit(HomeError(message: error.message));
    }
    final imagePaths = await imageRepo.getImages().then(
      (r) => r.fold((l) => current.imagePath, (r) => r),
    );
    emit(current.copyWith(imagePath: imagePaths));
  }

  Future<void> _onResetImage(ResetImage event, Emitter<HomeState> emit) async {
    if (state is! HomeLoaded) return;

    final current = state as HomeLoaded;

    emit(HomeLoading());

    final result = await imageRepo.resetImage(event.index);

    final error = result.fold((l) => l, (r) => null);
    if (error != null) {
      emit(HomeError(message: error.message));
    }
    final imagePaths = await imageRepo.getImages().then(
      (r) => r.fold((l) => current.imagePath, (r) => r),
    );

    emit(current.copyWith(imagePath: imagePaths));
  }

  Future<void> _onRenameRelay(
    RenameHomeEvent event,

    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final curentState = state as HomeLoaded;
      final updatedNames = List<String>.from(curentState.relayNames);
      updatedNames[event.index] = event.newName;

      final res = await localRepo.updateLocalRelayNames(updatedNames);

      res.fold(
        (l) => emit(HomeError(message: l.message)),
        (r) => emit(curentState.copyWith(relayNames: updatedNames)),
      );
    }
  }

  Future<String> getIpAddress() async {
    final ipRes = await localRepo.getLocalIp();
    final error = ipRes.fold((l) => l, (r) => null);
    if (error != null) {
      return 'IP tidak ditemukan';
    }
    final ip = ipRes.fold((l) => null, (r) => r);
    return ip ?? 'IP tidak ditemukan';
  }

  Future<List<String>> getRelayNames() async {
    final nameRes = await localRepo.getLocalRelayNames();
    final error = nameRes.fold((l) => l, (r) => null);
    if (error != null) {
      return [];
    }
    final names = nameRes.fold((l) => null, (r) => r);
    return names ?? [];
  }

  Future<List<String>> getImages() async {
    final imageRes = await imageRepo.getImages();
    final error = imageRes.fold((l) => l, (r) => null);
    if (error != null) {
      return [];
    }
    final images = imageRes.fold((l) => null, (r) => r);
    return images ?? [];
  }
}
