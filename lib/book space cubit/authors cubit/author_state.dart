part of 'author_cubit.dart';

@immutable
sealed class AuthorState {}

final class AuthorInitial extends AuthorState {}

final class AuthorExpand extends AuthorState {}

final class AuthorLoading extends AuthorState {}

final class AuthorSuccess extends AuthorState {
  final List data;

  AuthorSuccess(this.data);
}

final class AuthorFailure extends AuthorState {
  final String message;
  AuthorFailure({required this.message});
}
