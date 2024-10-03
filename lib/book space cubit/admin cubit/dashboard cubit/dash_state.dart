part of 'dash_cubit.dart';

@immutable
sealed class DashState {}

final class DashInitial extends DashState {}

final class DashLoading extends DashState {}

final class DashSuccess extends DashState {}
