import 'package:equatable/equatable.dart';

import '../../../cores/models/button_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadRelayStatusEvent extends HomeEvent {}

class PickImageEvent extends HomeEvent {
  final ButtonModel button;
  final String pickedImage;

  const PickImageEvent({required this.button, required this.pickedImage});

  @override
  List<Object> get props => [button, pickedImage];
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
  final ButtonModel button;

  const ResetImage({required this.button});

  @override
  List<Object> get props => [button];
}

class RenameHomeEvent extends HomeEvent {
  final ButtonModel button;
  final String newName;

  const RenameHomeEvent({required this.button, required this.newName});

  @override
  List<Object> get props => [button, newName];
}
