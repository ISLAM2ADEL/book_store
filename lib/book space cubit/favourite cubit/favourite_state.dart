part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteSuccess extends FavouriteState {
  final List data;

  FavouriteSuccess(this.data);
}

final class FavouriteFailure extends FavouriteState {
  final String message;
  FavouriteFailure({required this.message});
}

final class FavouriteAddLoading extends FavouriteState {}

final class FavouriteAddSuccess extends FavouriteState {}

final class FavouriteAddFailure extends FavouriteState {}
