part of 'best_cubit.dart';

@immutable
sealed class BestState {}

final class BestInitial extends BestState {}

final class BestSeller extends BestState {}

final class BestLatest extends BestState {}

final class BestComingSoon extends BestState {}

final class BestLoading extends BestState {}

final class BestSuccess extends BestState {
  final List<QueryDocumentSnapshot> data;

  BestSuccess(this.data);
}

final class BestFailure extends BestState {
  final String message;
  BestFailure({required this.message});
}
