import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_bar_state.dart';

enum AdminBar { addBook, updateBook, dashboard }

class AdminBarCubit extends Cubit<AdminBarState> {
  AdminBarCubit() : super(AdminBarInitial());

  AdminBar barChoice = AdminBar.addBook;

  void addBook() {
    barChoice = AdminBar.addBook;
    emit(BottomAddBook());
  }

  void updateBook() {
    barChoice = AdminBar.updateBook;
    emit(BottomUpdateBook());
  }

  void dashboard() {
    barChoice = AdminBar.dashboard;
    emit(BottomDashboard());
  }

  AdminBar getBarChoice() {
    return barChoice;
  }
}
