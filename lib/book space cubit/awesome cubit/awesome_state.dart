part of 'awesome_cubit.dart';

@immutable
sealed class AwesomeState {}

final class AwesomeInitial extends AwesomeState {}

final class AwesomeErrorState extends AwesomeState {}
