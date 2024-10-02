import 'package:bloc/bloc.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  bool isImage = false;
  bool isPicked = false;
  bool isUpdated = false;
  FirebaseBook firebaseBook = FirebaseBook();

  Future<void> uploadImage() async {
    isImage = await firebaseBook.pickImage();
    if (isImage) {
      isPicked = true;
    }
  }

  bool getIsPicked() {
    return isPicked;
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

  void resetImagePicker() {
    isPicked = false;

    emit(ImageInitial());
  }

  void update() {
    isUpdated = true;
  }

  bool getUpdated() {
    return isUpdated;
  }

  void resetUpdate() {
    isUpdated = false;
    emit(ImageInitial());
  }

  void updateBook({
    required String bookName,
    required String description,
    required String author,
    required String category,
    required String price,
    required String rate,
  }) async {
    emit(ImageUpdateLoading());
    try {
      await firebaseBook.updateBook(
        bookName: bookName,
        description: description,
        author: author,
        category: category,
        price: price,
        rate: rate,
      );
      emit(ImageUpdateSuccessful());
    } catch (e) {
      emit(ImageUpdateFailure(message: e.toString()));
    }
  }
}
