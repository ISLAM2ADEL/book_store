import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  FirebaseBook firebaseBook = FirebaseBook();

  Future<void> setFavorite(String bookName, BuildContext context) async {
    emit(FavouriteAddLoading());
    try {
      await firebaseBook.addUserFavorites(bookName);
      Get.snackbar(
        "Added to Favorite",
        "Book is Added to Favorite Section",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      emit(FavouriteAddSuccess());
    } catch (e) {
      emit(FavouriteAddFailure());
    }
  }

  Future<List<Map<String, dynamic>>> getFavBooks(String userEmail) async {
    emit(FavouriteLoading());
    try {
      List<Map<String, dynamic>> data =
          await firebaseBook.fetchFavoriteBookDetails(userEmail);
      data.isEmpty
          ? emit(FavouriteFailure(
              message: "Nothing Found in Favourites please Add First"))
          : emit(FavouriteSuccess(data));
      return data;
    } catch (e) {
      emit(FavouriteFailure(message: e.toString()));
      return [];
    }
  }
}
