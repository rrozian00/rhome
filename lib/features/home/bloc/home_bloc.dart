import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:rhome/features/home/bloc/home_event.dart';
import 'package:rhome/features/home/bloc/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String esp32Ip = "192.168.0.110"; // ← IP ESP32 kamu
  late StreamSubscription _connectionStream;

  HomeBloc() : super(HomeInitial()) {
    on<LoadRelayNamesEvent>(_onLoadRelayNames);
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
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      try {
        final response = await http.get(Uri.parse("http://$esp32Ip"));
        final currentState = state as HomeLoaded;
        if (response.statusCode == 200 && !currentState.isConnected) {
          emit(currentState.copyWith(isConnected: true));
        }
      } catch (e) {
        final currentState = state as HomeLoaded;
        if (currentState.isConnected) {
          emit(currentState.copyWith(isConnected: false));
        }
      }
    }
  }

  void _onLoadRelayNames(
    LoadRelayNamesEvent event,
    Emitter<HomeState> emit,
  ) async {
    await Future.delayed(Duration(milliseconds: 1000));
    final pref = await SharedPreferences.getInstance();
    final savedNames = pref.getStringList('relayNames');
    final relayNames =
        savedNames ?? List.generate(6, (index) => 'Relay ${index + 1}');
    final relayStates = List.filled(6, false);
    emit(
      HomeLoaded(
        isConnected: true,
        relayNames: relayNames,
        relayStates: relayStates,
      ),
    );
  }

  void _onToggleRelay(ToggleRelayEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedStates = List<bool>.from(currentState.relayStates);
      updatedStates[event.index] = event.value;
      emit(currentState.copyWith(relayStates: updatedStates));
    }
  }

  void _onRenameRelay(RenameRelayEvent event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final updatedNames = List<String>.from(currentState.relayNames);
      updatedNames[event.index] = event.newName;

      final pref = await SharedPreferences.getInstance();
      await pref.setStringList("relayNames", updatedNames);
      emit(currentState.copyWith(relayNames: updatedNames));
    }
  }

  Future<void> _onTurnOnRelay(
    TurnOnRelayEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://$esp32Ip/on${event.index + 1}"),
      );

      if (response.statusCode == 200) {
        // final responseBody = response.body;
        // debugPrint("Response: $responseBody");

        // Perbarui status relay di aplikasi
        add(ToggleRelayEvent(index: event.index, value: true));
      } else {
        throw Exception('Failed to turn on relay');
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _onTurnOffRelay(
    TurnOffRelayEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://$esp32Ip/off${event.index + 1}"),
      );

      if (response.statusCode == 200) {
        // // Proses JSON yang diterima
        // final responseBody = response.body;
        // debugPrint("Response: $responseBody");

        // Perbarui status relay di aplikasi
        add(ToggleRelayEvent(index: event.index, value: false));
      } else {
        throw Exception('Failed to turn off relay');
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Future<void> close() {
    _connectionStream.cancel();
    return super.close();
  }
}
