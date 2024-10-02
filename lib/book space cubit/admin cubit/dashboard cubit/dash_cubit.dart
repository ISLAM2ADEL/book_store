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
  int categories = 0;
  int authors = 0;
  FirebaseBook firebaseBook = FirebaseBook();

  Future<void> getBooks() async {
    int allBooks = await firebaseBook.getBookCount();
    books = allBooks;
    paidBooks = allBooks;
  }

  Future<void> getFreeBooks() async {
    int freeBooksCount = await firebaseBook.getFreeBookCount();
    freeBooks = freeBooksCount;
  }

  Future<void> getCategories() async {
    int categoriesCount = await firebaseBook.getCategoriesCount();
    categories = categoriesCount;
  }

  Future<void> getAuthors() async {
    int authorsCount = await firebaseBook.getAuthorsCount();
    authors = authorsCount;
  }

  int bookCounters() {
    return books;
  }

  int freeBookCounters() {
    return freeBooks;
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
