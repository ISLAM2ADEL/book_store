import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

enum Choice { mostPopular, allBooks }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Choice choice = Choice.mostPopular;
  FirebaseBook firebaseBook = FirebaseBook();
  List<QueryDocumentSnapshot> data = [];
  void mostPopular() {
    choice = Choice.mostPopular;
    getBooksMostPopular();
    emit(HomeMostPopular());
  }

  void forYou() {
    choice = Choice.allBooks;
    getAllBooks();
    emit(HomeForYou());
  }

  Choice getChoice() {
    return choice;
  }

  Future<List<QueryDocumentSnapshot>> getAllBooks() async {
    emit(HomeBooksLoading());
    try {
      List<QueryDocumentSnapshot> data = await firebaseBook.getAllBooks();
      emit(HomeBooksSuccess(data));
      return data;
    } catch (e) {
      emit(HomeBooksFailure(message: e.toString()));
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> getBooksMostPopular() async {
    emit(HomeBooksLoading());
    try {
      List<QueryDocumentSnapshot> data =
          await firebaseBook.getBooksMostPopular();
      emit(HomeBooksSuccess(data));
      return data;
    } catch (e) {
      emit(HomeBooksFailure(message: e.toString()));
      return [];
    }
  }
}
