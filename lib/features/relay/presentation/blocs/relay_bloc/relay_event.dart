import 'package:equatable/equatable.dart';

abstract class RelayEvent extends Equatable {
  const RelayEvent();

  @override
  List<Object> get props => [];
}

class LoadRelayNamesEvent extends RelayEvent {}

class LoadRelayStatusEvent extends RelayEvent {}

class PickImageEvent extends RelayEvent {
  final int index;

  const PickImageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class CheckConnectionEvent extends RelayEvent {}

class ToggleRelayEvent extends RelayEvent {
  final int index;
  final bool value;

  const ToggleRelayEvent({required this.index, required this.value});

  @override
  List<Object> get props => [index, value];
}

class TurnOnRelayEvent extends RelayEvent {
  final int index;

  const TurnOnRelayEvent(this.index);

  @override
  List<Object> get props => [index];
}

class TurnOffRelayEvent extends RelayEvent {
  final int index;

  const TurnOffRelayEvent(this.index);

  @override
  List<Object> get props => [index];
}

class ResetImage extends RelayEvent {
  final int index;

  const ResetImage(this.index);

  @override
  List<Object> get props => [index];
}

class RenameRelayEvent extends RelayEvent {
  final int index;
  final String newName;

  const RenameRelayEvent({required this.index, required this.newName});

  @override
  List<Object> get props => [index, newName];
}
