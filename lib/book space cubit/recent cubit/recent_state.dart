part of 'recent_cubit.dart';

@immutable
sealed class RecentState {}

final class RecentInitial extends RecentState {}

final class RecentLoading extends RecentState {}

final class RecentSuccess extends RecentState {
  final List<QueryDocumentSnapshot> data;

  RecentSuccess(this.data);
}

final class RecentFailure extends RecentState {
  final String message;
  RecentFailure({required this.message});
}
