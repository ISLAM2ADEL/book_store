import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

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
}
