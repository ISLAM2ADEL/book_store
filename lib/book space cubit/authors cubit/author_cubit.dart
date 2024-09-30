import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  AuthorCubit() : super(AuthorInitial());
  FirebaseBook firebaseBook = FirebaseBook();

  bool isExpand = false;
  Future<List> getAuthors() async {
    emit(AuthorLoading());
    try {
      List data = await firebaseBook.getAuthors();
      emit(AuthorSuccess(data));
      return data;
    } catch (e) {
      emit(AuthorFailure(message: e.toString()));
      return [];
    }
  }

  void expandAuthors() {
    isExpand = !isExpand;
    getAuthors();
    emit(AuthorExpand());
  }

  bool getExpand() {
    return isExpand;
  }
}
