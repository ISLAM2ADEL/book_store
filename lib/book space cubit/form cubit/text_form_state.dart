part of 'text_form_cubit.dart';

@immutable
sealed class TextFormState {}

final class TextFormInitial extends TextFormState {}

final class TextFormObscureText extends TextFormState {}

final class TextFormRememberMe extends TextFormState {}
