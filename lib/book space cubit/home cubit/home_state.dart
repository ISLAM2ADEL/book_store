part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeMostPopular extends HomeState {}

final class HomeForYou extends HomeState {}

final class HomeComingSoon extends HomeState {}

final class HomeLatest extends HomeState {}

final class HomeBestSeller extends HomeState {}
