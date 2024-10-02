import 'package:book_store/admin%20screens/edit%20book/edit_book.dart';
import 'package:book_store/book%20space%20cubit/admin%20cubit/edit%20book/edit_cubit.dart';
import 'package:book_store/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DeleteBookPage extends StatelessWidget {
  final String bookName;
  const DeleteBookPage({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<EditCubit>();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: height * .165,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              children: [
                const Text(
                  "Are you sure you want to delete ?",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                  height: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                  child: Row(
                    children: [
                      InkWell(
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: darkGreen,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          cubit.deleteBook(bookName);
                          Navigator.pop(context);
                          Future.delayed(const Duration(seconds: 1), () {
                            Get.snackbar(
                              "Book Deleted",
                              "Book Deleted Successfully",
                              colorText: Colors.white,
                              backgroundColor: Colors.green,
                            );
                            cubit.getAllBooks();
                            Get.offAll(EditBook());
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
