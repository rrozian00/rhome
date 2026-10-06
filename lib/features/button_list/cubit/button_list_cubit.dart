import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhome/cores/models/button_model.dart';
import 'package:rhome/cores/repositories/local_repository.dart';

part 'button_list_state.dart';

class ButtonListCubit extends Cubit<ButtonListState> {
  final LocalRepository localRepository;

  ButtonListCubit({required this.localRepository}) : super(ButtonListInitial());

  Future<void> addButton(ButtonModel button) async {
    emit(ButtonListLoading());

    final res = await localRepository.saveButton(button);
    final error = res.fold((l) => l, (r) => null);
    if (error != null) {
      emit(ButtonListError(error.message));
      return;
    }

    loadButtons();
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

  Future<void> deleteButton(int id) async {
    emit(ButtonListLoading());
    final res = await localRepository.deleteButton(id);
    final error = res.fold((l) => l, (r) => null);
    if (error != null) {
      emit(ButtonListError(error.message));
      return;
    }
    loadButtons();
  }

  Future<void> updateButton(ButtonModel button) async {
    emit(ButtonListLoading());
    final res = await localRepository.updateButton(button);
    final error = res.fold((l) => l, (r) => null);
    if (error != null) {
      emit(ButtonListError(error.message));
      return;
    }
    loadButtons();
  }
}
