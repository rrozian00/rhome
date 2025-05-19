import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rhome/features/home/data/local/image_repository.dart';
import 'package:rhome/features/home/data/remote/home_repository.dart';

import 'package:rhome/features/home/presentation/bloc/relay_event.dart';
import 'package:rhome/features/home/presentation/bloc/relay_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RelayBloc extends Bloc<RelayEvent, RelayState> {
  final _homeRepo = HomeRepository();
  final _imageRepo = ImageRepository();
  late StreamSubscription _connectionStream;

  RelayBloc() : super(RelayInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<ResetImage>(_onResetImage);
    on<LoadRelayNamesEvent>(_onLoadRelayNames);
    on<LoadRelayStatusEvent>(_checkRelayStatus);
    on<ToggleRelayEvent>(_onToggleRelay);
    on<RenameRelayEvent>(_onRenameRelay);
    on<TurnOnRelayEvent>(_onTurnOnRelay);
    on<TurnOffRelayEvent>(_onTurnOffRelay);
    on<CheckConnectionEvent>(_checkConnection);

    // Menggunakan Stream.periodic untuk cek koneksi secara periodik
    _connectionStream = Stream.periodic(Duration(seconds: 3)).listen((_) {
      add(CheckConnectionEvent());
    });
  }

  Future<void> _checkConnection(
    CheckConnectionEvent event,
    Emitter<RelayState> emit,
  ) async {
    if (state is RelayLoaded) {
      try {
        final response = await http.get(
          Uri.parse("http://${_homeRepo.esp32Ip}"),
        );
        final currentState = state as RelayLoaded;
        if (response.statusCode == 200 && !currentState.isConnected) {
          emit(currentState.copyWith(isConnected: true));
        }
      } catch (e) {
        final currentState = state as RelayLoaded;
        if (currentState.isConnected) {
          emit(currentState.copyWith(isConnected: false));
        }
      }
    }
  }

  Future<void> _checkRelayStatus(
    LoadRelayStatusEvent event,
    Emitter<RelayState> emit,
  ) async {
    if (state is RelayLoaded) {
      final currentState = state as RelayLoaded;
      final result = await _homeRepo.getRelayStatus();

      result.fold(
        (failure) {
          emit(RelayError(message: failure.message));
        },
        (relayStatuses) {
          // Jika jumlah status yang didapat beda dengan jumlah state, sesuaikan
          List<bool> updatedStates = List.filled(
            currentState.relayStates.length,
            false,
          );
          for (
            int i = 0;
            i < relayStatuses.length && i < updatedStates.length;
            i++
          ) {
            updatedStates[i] = relayStatuses[i];
          }
          emit(currentState.copyWith(relayStates: updatedStates));
        },
      );
    }
  }

  void _onLoadRelayNames(
    LoadRelayNamesEvent event,
    Emitter<RelayState> emit,
  ) async {
    emit(RelayLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    final pref = await SharedPreferences.getInstance();
    final savedNames = pref.getStringList('relayNames');
    final relayNames =
        savedNames ?? List.generate(4, (index) => 'Ruang ${index + 1}');
    final relayStates = List.filled(4, true);
    final imagePath = await _imageRepo.getImages();

    emit(
      RelayLoaded(
        isConnected: true,
        relayNames: relayNames,
        relayStates: relayStates,
        imagePath: imagePath.getOrElse(() => List.filled(4, "")),
      ),
    );
  }

  void _onToggleRelay(ToggleRelayEvent event, Emitter<RelayState> emit) {
    if (state is RelayLoaded) {
      final currentState = state as RelayLoaded;
      final updatedStates = List<bool>.from(currentState.relayStates);
      updatedStates[event.index] = event.value;
      emit(currentState.copyWith(relayStates: updatedStates));
    }
  }

  void _onRenameRelay(RenameRelayEvent event, Emitter<RelayState> emit) async {
    if (state is RelayLoaded) {
      final currentState = state as RelayLoaded;
      final updatedNames = List<String>.from(currentState.relayNames);
      updatedNames[event.index] = event.newName;

      final pref = await SharedPreferences.getInstance();
      await pref.setStringList("relayNames", updatedNames);
      emit(currentState.copyWith(relayNames: updatedNames));
    }
  }

  Future<void> _onTurnOnRelay(
    TurnOnRelayEvent event,
    Emitter<RelayState> emit,
  ) async {
    final result = await _homeRepo.getResponseOn(event.index);
    result.fold(
      (err) {
        emit(RelayError(message: err.message));
      },
      (res) {
        add(ToggleRelayEvent(index: event.index, value: true));
      },
    );
  }

  Future<void> _onTurnOffRelay(
    TurnOffRelayEvent event,
    Emitter<RelayState> emit,
  ) async {
    final result = await _homeRepo.getResponseOff(event.index);
    result.fold(
      (err) {
        emit(RelayError(message: err.message));
      },
      (res) {
        add(ToggleRelayEvent(index: event.index, value: false));
      },
    );
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<RelayState> emit,
  ) async {
    emit(RelayLoading());
    final result = await _imageRepo.setImage(event.index);
    result.fold(
      (err) {
        emit(RelayError(message: err.message));
      },
      (_) {
        emit(RelayInitial());
      },
    );
  }

  @override
  Future<void> close() {
    _connectionStream.cancel();
    return super.close();
  }

  Future<void> _onResetImage(ResetImage event, Emitter<RelayState> emit) async {
    emit(RelayLoading());
    final result = await _imageRepo.resetImage(event.index);
    result.fold(
      (err) {
        emit(RelayError(message: err.message));
      },
      (_) {
        emit(RelayInitial());
      },
    );
  }
}
