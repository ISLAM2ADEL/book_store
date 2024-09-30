import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20auth/firebase_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'text_form_state.dart';

class TextFormCubit extends Cubit<TextFormState> {
  TextFormCubit() : super(TextFormInitial());
  bool obscureText = true;
  FirebaseForm firebaseAuth = FirebaseForm();

  bool getObscureText() {
    return obscureText;
  }

  void changeObscureText() {
    obscureText = !obscureText;
    emit(TextFormObscureText());
  }

  Future<void> logIn(
      BuildContext context, String email, String password) async {
    emit(TextFormLoading());
    try {
      await firebaseAuth.signInUser(context, email, password);
      emit(TextFormSuccess());
    } catch (e) {
      emit(TextFormFailed(message: e.toString()));
    }
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    emit(TextFormLoading());
    try {
      await firebaseAuth.registerUser(context, email, password);
      emit(TextFormSuccess());
    } catch (e) {
      emit(TextFormFailed(message: e.toString()));
    }
  }

  void googleSigning() async {
    emit(TextFormLoading());
    try {
      await firebaseAuth.signInWithGoogle();
      emit(TextFormSuccess());
    } catch (e) {
      emit(TextFormFailed(message: e.toString()));
    }
  }
}
