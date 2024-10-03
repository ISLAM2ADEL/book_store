import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProfile {
  String? getEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }

  Future<void> setPhoto(File imgFile, String email) async {
    try {
      // Step 1: Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_profile/$email/profile_image.jpg');

      // Upload the file
      await storageRef.putFile(imgFile);

      // Get the download URL for the uploaded file
      final imageUrl = await storageRef.getDownloadURL();

      // Step 2: Save the image URL in Firestore under the 'user_profile' collection and sub-collection of email
      await FirebaseFirestore.instance
          .collection('user_profile')
          .doc(email)
          .set({'profile_image': imageUrl}, SetOptions(merge: true));

      print('Image uploaded and URL saved: $imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<String> getPhoto(String email) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user_profile')
          .doc(email)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('profile_image')) {
          String imageUrl = userData['profile_image'];
          return imageUrl; // Corrected line
        } else {
          return 'No profile image found for this user.';
        }
      } else {
        return 'User document does not exist.';
      }
    } catch (e) {
      return 'Error retrieving profile image: $e';
    }
  }
}