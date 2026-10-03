import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadRelayStatusEvent extends HomeEvent {}

class PickImageEvent extends HomeEvent {
  final int index;

  const PickImageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class TurnOnHomeEvent extends HomeEvent {
  final int index;

  const TurnOnHomeEvent(this.index);

  @override
  List<Object> get props => [index];
}

class TurnOffHomeEvent extends HomeEvent {
  final int index;

  const TurnOffHomeEvent(this.index);

  @override
  List<Object> get props => [index];
}

class ResetImage extends HomeEvent {
  final int index;

  const ResetImage(this.index);

  @override
  List<Object> get props => [index];
}

class RenameHomeEvent extends HomeEvent {
  final int index;
  final String newName;

  const RenameHomeEvent({required this.index, required this.newName});

  @override
  List<Object> get props => [index, newName];
}
