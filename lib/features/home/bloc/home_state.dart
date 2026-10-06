import 'package:equatable/equatable.dart';
import 'package:rhome/features/models/button_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeLoaded extends HomeState {
  final String ipAddress;
  final bool isConnected;
  final List<ButtonModel> buttons;
  final List<bool> relayStates;

  const HomeLoaded({
    required this.ipAddress,
    required this.isConnected,

    required this.buttons,
    required this.relayStates,
  });

  HomeLoaded copyWith({
    String? ipAddress,
    bool? isConnected,
    List<ButtonModel>? buttons,
    List<bool>? relayStates,
  }) {
    return HomeLoaded(
      ipAddress: ipAddress ?? this.ipAddress,
      isConnected: isConnected ?? this.isConnected,
      buttons: buttons ?? List.of(this.buttons),
      relayStates: relayStates ?? List.of(this.relayStates),
    );
  }

  @override
  List<Object> get props => [isConnected, buttons, relayStates];
}
