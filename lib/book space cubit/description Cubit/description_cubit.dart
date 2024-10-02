import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'description_state.dart';

class DescriptionCubit extends Cubit<DescriptionState> {
  DescriptionCubit() : super(DescriptionInitial());
  FirebaseBook firebaseBook = FirebaseBook();

  Future<List<QueryDocumentSnapshot>> getDescription(String name) async {
    emit(DescriptionLoading());
    try {
      List<QueryDocumentSnapshot> data =
          await firebaseBook.getBookDescription(name);
      emit(DescriptionSuccess(data));
      return data;
    } catch (e) {
      emit(DescriptionFailure(message: e.toString()));
      return [];
    }
  }
}
