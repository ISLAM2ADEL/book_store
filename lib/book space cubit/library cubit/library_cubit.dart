import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../firebase/firebase book/firebase_book.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryInitial());
  FirebaseBook firebaseBook = FirebaseBook();

  Future<void> setLibrary(String bookName, BuildContext context) async {
    emit(LibraryAddLoading());
    try {
      await firebaseBook.addUserLibraryBook(bookName);
      Get.snackbar(
        "Added to Library",
        "Book is Added to Library Section",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      emit(LibraryAddSuccess());
    } catch (e) {
      emit(LibraryAddFailure());
    }
  }

  Future<List<Map<String, dynamic>>> getLibraryBooks(String userEmail) async {
    emit(LibraryLoading());
    try {
      List<Map<String, dynamic>> data =
          await firebaseBook.fetchLibraryBookDetails(userEmail);
      data.isEmpty
          ? emit(LibraryFailure(
              message: "Nothing Found in Favourites please Add First"))
          : emit(LibrarySuccess(data));
      return data;
    } catch (e) {
      emit(LibraryFailure(message: e.toString()));
      return [];
    }
  }

  Future<void> deleteLibrary(String bookName, BuildContext context) async {
    emit(LibraryDeleteLoading());
    try {
      await firebaseBook.deleteUserLibraryBook(bookName);
      Get.snackbar(
        "Removed from Favorite",
        "Book is Removed from Favorite Section",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      emit(LibraryDeleteSuccess());
    } catch (e) {
      emit(LibraryDeleteFailure());
    }
  }
}
