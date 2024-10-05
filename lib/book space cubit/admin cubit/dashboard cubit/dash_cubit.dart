import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'dash_state.dart';

class DashCubit extends Cubit<DashState> {
  DashCubit() : super(DashInitial());

  int books = 0;
  int paidBooks = 0;
  int freeBooks = 0;
  int recentBooks = 0;
  int categories = 0;
  int authors = 0;
  FirebaseBook firebaseBook = FirebaseBook();

  Future<void> getBooks() async {
    emit(DashLoading());
    try {
      int allBooks = await firebaseBook.getBookCount();
      books = allBooks;
      paidBooks = allBooks;
      emit(DashSuccess());
    } catch (e) {}
  }

  Future<void> getFreeBooks() async {
    emit(DashLoading());
    try {
      int freeBooksCount = await firebaseBook.getFreeBookCount();
      freeBooks = freeBooksCount;
      emit(DashSuccess());
    } catch (e) {}
  }

  Future<void> getRecentBooks() async {
    emit(DashLoading());
    try {
      int recentBooksCount = await firebaseBook.getRecentBookCount();
      recentBooks = recentBooksCount;
      emit(DashSuccess());
    } catch (e) {}
  }

  Future<void> getCategories() async {
    emit(DashLoading());
    try {
      int categoriesCount = await firebaseBook.getCategoriesCount();
      categories = categoriesCount;

      emit(DashSuccess());
    } catch (e) {}
  }

  Future<void> getAuthors() async {
    emit(DashLoading());
    try {
      int authorsCount = await firebaseBook.getAuthorsCount();
      authors = authorsCount;
      emit(DashSuccess());
    } catch (e) {}
  }

  int bookCounters() {
    return books;
  }

  int freeBookCounters() {
    return freeBooks;
  }

  int recentBookCounters() {
    return recentBooks;
  }

  int paidBookCounters() {
    return paidBooks - freeBooks;
  }

  int categoryCounters() {
    return categories;
  }

  int authorsCounters() {
    return authors;
  }
}
