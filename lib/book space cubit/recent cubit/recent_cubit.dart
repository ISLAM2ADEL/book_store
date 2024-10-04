import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'recent_state.dart';

class RecentCubit extends Cubit<RecentState> {
  RecentCubit() : super(RecentInitial());
  FirebaseBook firebaseBook = FirebaseBook();

  Future<List<QueryDocumentSnapshot>> getRecent() async {
    emit(RecentLoading());
    try {
      List<QueryDocumentSnapshot> data = await firebaseBook.getFreeBooks();
      emit(RecentSuccess(data));
      return data;
    } catch (e) {
      emit(RecentFailure(message: e.toString()));
      return [];
    }
  }
}
