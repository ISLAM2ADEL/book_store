import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditInitial());
  FirebaseBook firebaseBook = FirebaseBook();

  String searchTerm = ''; // Store search term

  // Method to set search term
  void setSearchTerm(String term) {
    searchTerm = term;
  }

  // Method to retrieve the search term
  String getSearchTerm() {
    return searchTerm;
  }

  Future<List<QueryDocumentSnapshot>> getAllBooks() async {
    emit(EditLoading());
    try {
      List<QueryDocumentSnapshot> data = await firebaseBook.getAllBooks();
      emit(EditSuccess(data));
      return data;
    } catch (e) {
      emit(EditFailure(message: e.toString()));
      return [];
    }
  }

  Future<void> getSpecifiedBook(String name) async {
    emit(EditLoading());
    try {
      List<QueryDocumentSnapshot> books =
          await firebaseBook.searchBooksByName(name);
      if (books.isNotEmpty) {
        emit(EditSuccess(books));
      } else {
        emit(EditFailure(message: "No books found matching: $name"));
      }
    } catch (e) {
      emit(EditFailure(message: e.toString()));
    }
  }

  Future<void> getBookData(String name) async {
    emit(EditDataLoading());
    try {
      List<QueryDocumentSnapshot> books =
          await firebaseBook.getBookDescription(name);
      if (books.isNotEmpty) {
        emit(EditDataSuccess(books));
      } else {
        emit(EditDataFailure(message: "No books found matching: $name"));
      }
    } catch (e) {
      emit(EditDataFailure(message: e.toString()));
    }
  }

  Future<void> deleteBook(String bookName) async {
    emit(EditDeleteLoading()); // Emit loading state

    try {
      // Call methods from FirebaseBook class to delete the book, image, and user favorites
      await firebaseBook.deleteBookFromFirestore(bookName);
      await firebaseBook.deleteBookImageFromStorage(bookName);
      await firebaseBook.deleteBookFromUserFavorites(bookName);

      emit(EditDeleteSuccess()); // Emit success state
    } catch (e) {
      emit(
          EditDeleteFailure()); // Emit failure state if any of the operations fail
      print("Error during book deletion: $e");
    }
  }
}
