part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

final class LibraryLoading extends LibraryState {}

final class LibrarySuccess extends LibraryState {
  final List data;

  LibrarySuccess(this.data);
}

final class LibraryFailure extends LibraryState {
  final String message;
  LibraryFailure({required this.message});
}

final class LibraryAddLoading extends LibraryState {}

final class LibraryAddSuccess extends LibraryState {}

final class LibraryAddFailure extends LibraryState {}

final class LibraryDeleteLoading extends LibraryState {}

final class LibraryDeleteSuccess extends LibraryState {}

final class LibraryDeleteFailure extends LibraryState {}
