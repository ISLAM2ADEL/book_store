part of 'image_cubit.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageUpload extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageSuccessful extends ImageState {}

class ImageFailure extends ImageState {
  final String message;

  ImageFailure({required this.message});
}
