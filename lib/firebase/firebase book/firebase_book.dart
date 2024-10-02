import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  void resetImage() {
    selectedImageFile = null;
  }

  Future<List<QueryDocumentSnapshot>> getAllBooks() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBooksBestSeller() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('price', isLessThanOrEqualTo: '14.99')
        .get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBooksMostPopular() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('rate', isGreaterThanOrEqualTo: '4.6')
        .orderBy('rate', descending: true)
        .get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getAlphabeticBooks() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .orderBy('name')
        .get();
    return querySnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> getFreeBooks() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('price', isEqualTo: 'Free')
        .get();
    return querySnapshot.docs;
  }

  Future<List> getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    Set<String> categories = {};
    for (var doc in querySnapshot.docs) {
      String category = doc[
          'category']; // Replace with the field name containing the category
      categories.add(category);
    }
    return categories.toList();
  }

  Future<List<QueryDocumentSnapshot>> getCategoryBook(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('category', isEqualTo: name)
        .get();
    return querySnapshot.docs;
  }

  Future<List> getAuthors() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    Set<String> categories = {};
    for (var doc in querySnapshot.docs) {
      String category =
          doc['author']; // Replace with the field name containing the category
      categories.add(category);
    }
    return categories.toList();
  }

  Future<List<QueryDocumentSnapshot>> getBookDescription(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('name', isEqualTo: name)
        .get();
    return querySnapshot.docs;
  }

  Future<void> addUserFavorites(String newFavoriteBook) async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      print('User email is null. Cannot add favorites.');
      return;
    }

    CollectionReference userFavorites =
        FirebaseFirestore.instance.collection('user_favorites');

    DocumentReference userDoc = userFavorites.doc(userEmail);

    DocumentSnapshot docSnapshot = await userDoc.get();

    List<String> favoriteBooks = [];
    if (docSnapshot.exists && docSnapshot.data() != null) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('favorites')) {
        favoriteBooks = List<String>.from(data['favorites']);
      }
    }
    if (!favoriteBooks.contains(newFavoriteBook)) {
      favoriteBooks.add(newFavoriteBook); // Add the new book
    }
    await userDoc.set({
      'favorites': favoriteBooks,
    }, SetOptions(merge: true));
  }

  // Fetches the favorite books for the given user email
  Future<List<String>> getFavoriteBooks(String userEmail) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user_favorites')
        .doc(userEmail)
        .get();

    if (snapshot.exists) {
      List<dynamic> favorites = snapshot.data()?['favorites'];
      return favorites.cast<String>();
    } else {
      throw Exception('No favorites found for this user.');
    }
  }

// Fetches details of a specific book by name
  Future<Map<String, dynamic>> getBookDetails(String bookName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('name', isEqualTo: bookName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      throw Exception('Book not found');
    }
  }

// Fetches details of the favorite books for the given user email
  Future<List<Map<String, dynamic>>> fetchFavoriteBookDetails(
      String userEmail) async {
    try {
      // Step 1: Get the favorite books
      List<String> favoriteBooks = await getFavoriteBooks(userEmail);

      List<Map<String, dynamic>> bookDetailsList = [];

      // Step 2: Get details for each favorite book
      for (String book in favoriteBooks) {
        Map<String, dynamic> bookDetails = await getBookDetails(book);
        bookDetailsList.add(bookDetails);
      }

      return bookDetailsList;
    } catch (e) {
      print('Error fetching book details: $e');
      return []; // Return an empty list in case of error
    }
  }
}
