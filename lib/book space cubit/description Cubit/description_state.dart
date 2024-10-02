part of 'description_cubit.dart';

@immutable
sealed class DescriptionState {}

final class DescriptionInitial extends DescriptionState {}

final class DescriptionLoading extends DescriptionState {}

final class DescriptionSuccess extends DescriptionState {
  final List<QueryDocumentSnapshot> data;

  DescriptionSuccess(this.data);
}

final class DescriptionFailure extends DescriptionState {
  final String message;
  DescriptionFailure({required this.message});
}
