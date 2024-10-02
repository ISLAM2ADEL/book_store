part of 'edit_cubit.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}

final class EditLoading extends EditState {}

final class EditSuccess extends EditState {
  final List<QueryDocumentSnapshot> data;

  EditSuccess(this.data);
}

final class EditFailure extends EditState {
  final String message;
  EditFailure({required this.message});
}

final class EditDataLoading extends EditState {}

final class EditDataSuccess extends EditState {
  final List<QueryDocumentSnapshot> data;

  EditDataSuccess(this.data);
}

final class EditDataFailure extends EditState {
  final String message;
  EditDataFailure({required this.message});
}

final class EditDeleteLoading extends EditState {}

final class EditDeleteSuccess extends EditState {}

final class EditDeleteFailure extends EditState {
}