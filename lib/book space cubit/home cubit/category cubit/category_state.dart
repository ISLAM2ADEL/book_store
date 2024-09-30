part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List data;

  CategorySuccess(this.data);
}

final class CategoryFailure extends CategoryState {
  final String message;
  CategoryFailure({required this.message});
}

final class CategoryBooksLoading extends CategoryState {}

final class CategoryBooksSuccess extends CategoryState {
  final List data;

  CategoryBooksSuccess(this.data);
}

final class CategoryBooksFailure extends CategoryState {
  final String message;
  CategoryBooksFailure({required this.message});
}
