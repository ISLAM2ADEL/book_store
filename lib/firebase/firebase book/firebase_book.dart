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

  Future<List<QueryDocumentSnapshot>> searchBooksByName(String name) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThanOrEqualTo: name + '\uf8ff')
        .get();
    return querySnapshot.docs;
  }

  Future<void> updateBook(
      {required String bookName,
      required String description,
      required String author,
      required String category,
      required String price,
      required String rate}) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('name', isEqualTo: bookName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('books')
            .doc(querySnapshot.docs[0].id)
            .update({
          'description': description,
          'author': author,
          'category': category,
          'price': price,
          'rate': rate,
        });
        print("Book updated successfully");
      } else {
        print("No book found with the name: $bookName");
      }
    } catch (e) {
      print("Failed to update book: $e");
    }
  }

  Future<void> deleteBookFromFirestore(String bookName) async {
    try {
      // Query the book by name from the 'books' collection
      var querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('name', isEqualTo: bookName)
          .get();

      // Check if the book exists
      if (querySnapshot.docs.isNotEmpty) {
        // Delete the book from 'books' collection
        await FirebaseFirestore.instance
            .collection('books')
            .doc(querySnapshot.docs[0].id)
            .delete();
        print("Book deleted successfully from Firestore");
      } else {
        print("No book found with the name: $bookName");
      }
    } catch (e) {
      print("Failed to delete book from Firestore: $e");
    }
  }

  // Method to delete the book's image from Firebase Storage
  Future<void> deleteBookImageFromStorage(String bookName) async {
    try {
      // Try multiple possible extensions
      List<String> extensions = ['jpeg', 'jpg', 'png'];
      bool deleted = false;

      for (String ext in extensions) {
        String imagePath = 'images/$bookName.$ext';
        print("Attempting to delete image at: $imagePath");

        try {
          await FirebaseStorage.instance.ref(imagePath).delete();
          print("Image deleted successfully from Firebase Storage");
          deleted = true;
          break; // Exit loop if image was deleted successfully
        } catch (e) {
          print("Image not found at $imagePath");
        }
      }

      if (!deleted) {
        print(
            "Failed to delete image: No matching image found with any extension.");
      }
    } catch (e) {
      print("Failed to delete image from Firebase Storage: $e");
    }
  }

  // Method to delete the book from user favorites in Firestore
  Future<void> deleteBookFromUserFavorites(String bookName) async {
    try {
      // Fetch all users from 'user_favorites' collection
      var userFavoritesSnapshot =
          await FirebaseFirestore.instance.collection('user_favorites').get();

      // Loop through each user document
      for (var userDoc in userFavoritesSnapshot.docs) {
        // Get the user's favorites list
        List<dynamic> favorites = userDoc.data()['favorites'];

        // Check if the book is in the user's favorites list
        if (favorites.contains(bookName)) {
          // Remove the book from the favorites list
          favorites.remove(bookName);

          // Update the user's favorites list in Firestore
          await FirebaseFirestore.instance
              .collection('user_favorites')
              .doc(userDoc.id)
              .update({'favorites': favorites});

          print("Book removed from favorites for user: ${userDoc.id}");
        }
      }
    } catch (e) {
      print("Failed to delete book from user favorites: $e");
    }
  }

  Future<int> getBookCount() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    int documentCount = querySnapshot.docs.length;
    return documentCount;
  }

  Future<int> getFreeBookCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('price', isEqualTo: 'Free')
        .get();
    int documentCount = querySnapshot.docs.length;
    return documentCount;
  }

  Future<int> getCategoriesCount() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    Set<String> categories = {};
    for (var doc in querySnapshot.docs) {
      String category = doc[
          'category']; // Replace with the field name containing the category
      categories.add(category);
    }
    return categories.length;
  }

  Future<int> getAuthorsCount() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    Set<String> categories = {};
    for (var doc in querySnapshot.docs) {
      String category =
          doc['author']; // Replace with the field name containing the category
      categories.add(category);
    }
    return categories.length;
  }

  Future<void> deleteUserFavorites(String bookToRemove) async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      print('User email is null. Cannot remove favorite.');
      return;
    }

    CollectionReference userFavorites =
        FirebaseFirestore.instance.collection('user_favorites');

    DocumentReference userDoc = userFavorites.doc(userEmail);

    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists && docSnapshot.data() != null) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('favorites')) {
        List<String> favoriteBooks = List<String>.from(data['favorites']);

        if (favoriteBooks.contains(bookToRemove)) {
          favoriteBooks.remove(bookToRemove); // Remove the book

          // Update Firestore with the new list of favorite books
          await userDoc.set({
            'favorites': favoriteBooks,
          }, SetOptions(merge: true));
        } else {
          print('Book not found in favorites.');
        }
      }
    } else {
      print('No favorites found for this user.');
    }
  }

  // Adds a new book to the user's library
  Future<void> addUserLibraryBook(String newLibraryBook) async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      print('User email is null. Cannot add to library.');
      return;
    }

    CollectionReference userLibrary =
        FirebaseFirestore.instance.collection('user_library');

    DocumentReference userDoc = userLibrary.doc(userEmail);

    DocumentSnapshot docSnapshot = await userDoc.get();

    List<String> libraryBooks = [];
    if (docSnapshot.exists && docSnapshot.data() != null) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('library')) {
        libraryBooks = List<String>.from(data['library']);
      }
    }

    if (!libraryBooks.contains(newLibraryBook)) {
      libraryBooks.add(newLibraryBook); // Add the new book
    }

    await userDoc.set({
      'library': libraryBooks,
    }, SetOptions(merge: true));
  }

// Fetches the books in the user's library for the given user email
  Future<List<String>> getLibraryBooks(String userEmail) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user_library')
        .doc(userEmail)
        .get();

    if (snapshot.exists) {
      List<dynamic> library = snapshot.data()?['library'];
      return library.cast<String>();
    } else {
      throw Exception('No library books found for this user.');
    }
  }

// Fetches details of the library books for the given user email
  Future<List<Map<String, dynamic>>> fetchLibraryBookDetails(
      String userEmail) async {
    try {
      // Step 1: Get the library books
      List<String> libraryBooks = await getLibraryBooks(userEmail);

      List<Map<String, dynamic>> bookDetailsList = [];

      // Step 2: Get details for each library book
      for (String book in libraryBooks) {
        Map<String, dynamic> bookDetails = await getBookDetails(book);
        bookDetailsList.add(bookDetails);
      }

      return bookDetailsList;
    } catch (e) {
      print('Error fetching library book details: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<void> deleteUserLibraryBook(String bookToRemove) async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) {
      print('User email is null. Cannot remove book from library.');
      return;
    }

    CollectionReference userLibrary =
        FirebaseFirestore.instance.collection('user_library');

    DocumentReference userDoc = userLibrary.doc(userEmail);

    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists && docSnapshot.data() != null) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('library')) {
        List<String> libraryBooks = List<String>.from(data['library']);

        if (libraryBooks.contains(bookToRemove)) {
          libraryBooks.remove(bookToRemove); // Remove the book

          // Update Firestore with the new list of library books
          await userDoc.set({
            'library': libraryBooks,
          }, SetOptions(merge: true));
        } else {
          print('Book not found in library.');
        }
      }
    } else {
      print('No library books found for this user.');
    }
  }

  Future<List<QueryDocumentSnapshot>> getRecent() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .where('category', isEqualTo: 'Recent')
        .get();
    return querySnapshot.docs;
  }
}
