part of 'button_list_cubit.dart';

sealed class ButtonListState extends Equatable {
  const ButtonListState();

  @override
  List<Object> get props => [];
}

final class ButtonListInitial extends ButtonListState {}

final class ButtonListLoading extends ButtonListState {}

final class ButtonListError extends ButtonListState {
  final String message;

  const ButtonListError(this.message);

  @override
  List<Object> get props => [message];
}

final class ButtonListLoaded extends ButtonListState {
  final List<ButtonModel> buttons;

  const ButtonListLoaded(this.buttons);

  @override
  List<Object> get props => [buttons];
}
