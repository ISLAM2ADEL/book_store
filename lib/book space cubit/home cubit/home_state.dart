part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeMostPopular extends HomeState {}

final class HomeForYou extends HomeState {}

final class HomeComingSoon extends HomeState {}

final class HomeLatest extends HomeState {}

final class HomeBestSeller extends HomeState {}

final class HomeBooksLoading extends HomeState {}

final class HomeBooksSuccess extends HomeState {
  final List<QueryDocumentSnapshot> data;

  HomeBooksSuccess(this.data);
}

final class HomeBooksFailure extends HomeState {
  final String message;
  HomeBooksFailure({required this.message});
}

final class HomeBooksBestLoading extends HomeState {}

final class HomeBooksBestSuccess extends HomeState {
  final List<QueryDocumentSnapshot> data;

  HomeBooksBestSuccess(this.data);
}

final class HomeBooksBestFailure extends HomeState {
  final String message;
  HomeBooksBestFailure({required this.message});
}
