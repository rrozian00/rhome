import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/features/models/button_model.dart';
import 'package:rhome/features/repositories/local_repository.dart';

part 'button_list_state.dart';

class ButtonListCubit extends Cubit<ButtonListState> {
  final LocalRepository localRepository;

  ButtonListCubit({required this.localRepository}) : super(ButtonListInitial());

  Future<void> addButton(ButtonModel button) async {
    emit(ButtonListLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      final currentState = state;
      if (currentState is ButtonListLoaded) {
        final updatedButtons = List<ButtonModel>.from(currentState.buttons)
          ..add(button);
        emit(ButtonListLoaded(updatedButtons));
      } else {
        emit(ButtonListLoaded([button]));
      }
    } catch (e) {
      emit(ButtonListError(e.toString()));
    }
  }

  Future<void> loadButtons() async {
    emit(ButtonListLoading());
    try {
      final buttons = await localRepository.getButtons();
      buttons.fold(
        (failure) => emit(ButtonListError(failure.message)),
        (buttons) => emit(ButtonListLoaded(buttons)),
      );
    } catch (e) {
      emit(ButtonListError(e.toString()));
    }
  }
}
