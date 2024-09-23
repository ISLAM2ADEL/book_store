import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

enum Choice { mostPopular, forYou }

enum Book { bestSeller, latest, comingSoon }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Choice choice = Choice.mostPopular;
  Book book = Book.bestSeller;

  void mostPopular() {
    choice = Choice.mostPopular;
    emit(HomeMostPopular());
  }

  void forYou() {
    choice = Choice.forYou;
    emit(HomeForYou());
  }

  Choice getChoice() {
    return choice;
  }

  void bestSeller() {
    book = Book.bestSeller;
    emit(HomeBestSeller());
  }

  void latest() {
    book = Book.latest;
    emit(HomeLatest());
  }

  void comingSoon() {
    book = Book.comingSoon;
    emit(HomeComingSoon());
  }

  Book getBook() {
    return book;
  }
}
