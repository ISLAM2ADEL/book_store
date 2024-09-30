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
