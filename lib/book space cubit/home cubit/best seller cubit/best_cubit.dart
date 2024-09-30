import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'best_state.dart';

enum Book { bestSeller, alphabetic, free }

class BestCubit extends Cubit<BestState> {
  BestCubit() : super(BestInitial());
  Book book = Book.bestSeller;
  FirebaseBook firebaseBook = FirebaseBook();
  void bestSeller() {
    book = Book.bestSeller;
    getBooksBestSeller();
    emit(BestSeller());
  }

  void alphabetic() {
    book = Book.alphabetic;
    getAlphabeticBooks();
    emit(BestLatest());
  }

  void freeBooks() {
    book = Book.free;
    getFreeBooks();
    emit(BestComingSoon());
  }

  Book getBook() {
    return book;
  }

  Future<List<QueryDocumentSnapshot>> getBooksBestSeller() async {
    emit(BestLoading());
    try {
      List<QueryDocumentSnapshot> data =
          await firebaseBook.getBooksBestSeller();
      emit(BestSuccess(data));
      return data;
    } catch (e) {
      emit(BestFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> getAlphabeticBooks() async {
    emit(BestLoading());
    try {
      List<QueryDocumentSnapshot> data =
          await firebaseBook.getAlphabeticBooks();
      emit(BestSuccess(data));
      return data;
    } catch (e) {
      emit(BestFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> getFreeBooks() async {
    emit(BestLoading());
    try {
      List<QueryDocumentSnapshot> data = await firebaseBook.getFreeBooks();
      emit(BestSuccess(data));
      return data;
    } catch (e) {
      emit(BestFailure(message: e.toString()));
      return [];
    }
  }
}
