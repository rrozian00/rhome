import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadRelayNamesEvent extends HomeEvent {}

class LoadRelayStatusEvent extends HomeEvent {}

class CheckConnectionEvent extends HomeEvent {}

class ToggleRelayEvent extends HomeEvent {
  final int index;
  final bool value;

  const ToggleRelayEvent({required this.index, required this.value});

  @override
  List<Object> get props => [index, value];
}

class TurnOnRelayEvent extends HomeEvent {
  final int index;

  const TurnOnRelayEvent(this.index);

  @override
  List<Object> get props => [index];
}

class TurnOffRelayEvent extends HomeEvent {
  final int index;

  const TurnOffRelayEvent(this.index);

  @override
  List<Object> get props => [index];
}

class RenameRelayEvent extends HomeEvent {
  final int index;
  final String newName;

  const RenameRelayEvent({required this.index, required this.newName});

  @override
  List<Object> get props => [index, newName];
}
