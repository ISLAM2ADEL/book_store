import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  bool isImage = false;
  FirebaseBook firebaseBook = FirebaseBook();

  Future<bool> uploadImage() async {
    return await firebaseBook.pickImage();
  }

  void addBook({
    required String bookName,
    required String description,
    required String author,
    required String category,
    required String price,
    required String rate,
  }) async {
    emit(ImageLoading());
    try {
      await firebaseBook.addBook(
        bookName,
        bookName: bookName,
        description: description,
        author: author,
        category: category,
        price: price,
        rate: rate,
      );
      emit(ImageSuccessful());
    } catch (e) {
      emit(ImageFailure(message: e.toString()));
    }
  }
}
