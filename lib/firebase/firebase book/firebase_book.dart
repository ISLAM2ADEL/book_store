import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseBook {
  Future<void> addImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${xFile?.path}');
  }
}
