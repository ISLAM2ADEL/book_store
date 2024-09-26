part of 'admin_bar_cubit.dart';

@immutable
sealed class AdminBarState {}

final class AdminBarInitial extends AdminBarState {}

final class BottomAddBook extends AdminBarState {}

final class BottomUpdateBook extends AdminBarState {}

final class BottomDashboard extends AdminBarState {}
