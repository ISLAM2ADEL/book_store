part of 'edit_profile_cubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class ProfileLoading extends EditProfileState {}

class ProfileUpdated extends EditProfileState {
  final String username;
  final String email;
  final File? imageFile;

  ProfileUpdated(this.username, this.email, this.imageFile);
}
