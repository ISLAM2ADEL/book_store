part of 'text_form_cubit.dart';

@immutable
sealed class TextFormState {}

final class TextFormInitial extends TextFormState {}

final class TextFormObscureText extends TextFormState {}

final class TextFormLoading extends TextFormState {}

final class TextFormSuccess extends TextFormState {}

final class TextFormFailed extends TextFormState {
  final String message;

  TextFormFailed({required this.message});
}
