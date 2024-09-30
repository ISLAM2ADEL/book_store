import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordCubit extends Cubit<List<bool>> {
  PasswordCubit()
      : super([true, true, true]); // Initial state: all passwords are obscured

  void togglePasswordVisibility(int index) {
    final updatedVisibility = List<bool>.from(state); // Copy the current state
    updatedVisibility[index] =
        !updatedVisibility[index]; // Toggle visibility for the specified index
    emit(updatedVisibility); // Emit the new state
  }
}
