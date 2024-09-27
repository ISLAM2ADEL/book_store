import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBook {
  String? imageUrl = ""; // URL for the uploaded image
  File? selectedImageFile; // File for the chosen image

  // Method to pick an image
  Future<bool> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      selectedImageFile = File(xFile.path);
      return true;
    } else {
      return false;
    }
  }

  // Method to upload the image and add the book
  Future<void> addBook(String imageName,
      {required String bookName,
      required String description,
      required String author,
      required String category,
      required String price,
      required String rate}) async {
    if (selectedImageFile == null) {
      throw Exception('No image selected. Please select an image first.');
    }

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(imageName);

    try {
      // Store the file
      await referenceImageToUpload.putFile(selectedImageFile!);
      // Success: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
      print('Image uploaded successfully: $imageUrl');

      await FirebaseFirestore.instance.collection('books').add({
        'name': bookName,
        'description': description,
        'author': author,
        'category': category,
        'price': price,
        'rate': rate,
        'imageUrl': imageUrl,
      });
    } catch (error) {
      throw Exception('Error occurred while uploading image: $error');
    }
  }
}