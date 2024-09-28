import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  final ImagePicker _picker = ImagePicker();
  String _username = "UserName";
  String _email = "aadna@gmail.com";
  File? _imageFile;

  void updateUsername(String username) {
    _username = username;
    emit(ProfileUpdated(_username, _email, _imageFile));
  }

  void updateEmail(String email) {
    _email = email;
    emit(ProfileUpdated(_username, _email, _imageFile));
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      emit(ProfileUpdated(_username, _email, _imageFile));
    }
  }

  void updateProfile() {
    emit(ProfileLoading());

    // Simulate a network call
    Future.delayed(Duration(seconds: 2), () {
      // Here you can add logic to update the profile in your backend
      emit(ProfileUpdated(_username, _email, _imageFile));
    });
  }
}
