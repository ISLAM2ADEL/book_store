import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebasr%20profile/firebase_profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../screens/setting screen/settings_screen.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  FirebaseProfile firebaseProfile = FirebaseProfile();

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? img = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
    );
    if (img != null) {
      emit(SettingsImagePicked(File(img.path)));
    }
  }

  String? getEmail() {
    String? email = firebaseProfile.getEmail();
    return email;
  }

  void setPhoto(File imgFile, String email) async {
    await firebaseProfile.setPhoto(imgFile, email);
    Get.offAll(const SettingsScreen());
  }

  Future<void> getPhoto(String email) async {
    emit(SettingLoading());
    try {
      String photo = await firebaseProfile.getPhoto(email);
      emit(SettingSuccess(photo));
    } catch (e) {}
  }
}
