import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forget_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgetPasswordSuccess());
    } catch (error) {
      emit(ForgetPasswordFailure(error.toString()));
    }
  }
}
