import 'package:book_store/book%20space%20cubit/admin%20cubit/bottom%20bar/admin_bar_cubit.dart';
import 'package:book_store/book%20space%20cubit/admin%20cubit/edit%20book/edit_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../book space cubit/admin cubit/dashboard cubit/dash_cubit.dart';
import '../add book/add_book.dart';
import '../dashboard screen/dashboard.dart';
import '../edit book/edit_book.dart';

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminBarCubit>();
    final editCubit = context.read<EditCubit>();
    final dashCubit = context.read<DashCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: BlocBuilder<AdminBarCubit, AdminBarState>(
            builder: (context, state) {
              AdminBar myChoice = cubit.getBarChoice();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: _bottomNavButtons(
                      icons: CupertinoIcons.add_circled_solid,
                      text: "Add Book",
                      bottomColor: myChoice == AdminBar.addBook
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      cubit.addBook();
                      Get.off(AddBook());
                    },
                  ),
                  InkWell(
                    child: _bottomNavButtons(
                      icons: Icons.edit_off_rounded,
                      text: "Edit Book",
                      bottomColor: myChoice == AdminBar.updateBook
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      cubit.updateBook();
                      editCubit.getAllBooks();
                      Get.off(EditBook());
                    },
                  ),
                  InkWell(
                    child: _bottomNavButtons(
                      icons: Icons.info,
                      text: "Dashboard",
                      bottomColor: myChoice == AdminBar.dashboard
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      cubit.dashboard();
                      dashCubit.getBooks();
                      dashCubit.getFreeBooks();
                      dashCubit.getAuthors();
                      dashCubit.getCategories();
                      dashCubit.getRecentBooks();
                      Get.off(() => const Dashboard());
                    },
                  ),
                ],
              );
            },
          )),
    );
  }

  Column _bottomNavButtons({
    required IconData icons,
    required String text,
    required Color bottomColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icons,
          color: bottomColor,
          size: 30,
        ),
        Text(
          text,
          style: TextStyle(
            color: bottomColor,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
