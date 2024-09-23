import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_state.dart';

enum Bar { home, favourite, category, myLibrary }

class BottomCubit extends Cubit<BottomState> {
  BottomCubit() : super(BottomInitial());

  Bar barChoice = Bar.home;

  void home() {
    barChoice = Bar.home;
    emit(BottomHome());
  }

  void favourite() {
    barChoice = Bar.favourite;
    emit(BottomFavourite());
  }

  void category() {
    barChoice = Bar.category;
    emit(BottomCategory());
  }

  void myLibrary() {
    barChoice = Bar.myLibrary;
    emit(BottomMyLibrary());
  }

  Bar getBarChoice() {
    return barChoice;
  }
}
