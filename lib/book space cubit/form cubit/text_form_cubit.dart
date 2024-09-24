import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_form_state.dart';

class TextFormCubit extends Cubit<TextFormState> {
  TextFormCubit() : super(TextFormInitial());

  bool obscureText = true;
  bool rememberMe = false;

  bool getObscureText() {
    return obscureText;
  }

  void changeObscureText() {
    obscureText = !obscureText;
    emit(TextFormObscureText());
  }
  bool getRememberMe() {
    return rememberMe;
  }

  void changeRememberMe() {
    rememberMe = !rememberMe;
    emit(TextFormRememberMe());
  }
}
