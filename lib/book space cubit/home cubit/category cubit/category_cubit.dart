import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  List<QueryDocumentSnapshot> data = [];
  FirebaseBook firebaseBook = FirebaseBook();

  Future<List> getCategories() async {
    emit(CategoryLoading());
    try {
      List data = await firebaseBook.getCategories();
      emit(CategorySuccess(data));
      return data;
    } catch (e) {
      emit(CategoryFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> getBooks(String name) async {
    emit(CategoryBooksLoading());
    try {
      data = await firebaseBook.getCategoryBook(name);
      emit(CategoryBooksSuccess(data));
      return data;
    } catch (e) {
      emit(CategoryBooksFailure(message: e.toString()));
      return [];
    }
  }
}
