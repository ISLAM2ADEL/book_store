import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import '../../book space cubit/library cubit/library_cubit.dart';
import '../../const.dart';
import '../Book_description/description.dart';
import '../custom bottom bar/custom_bottom_bar.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    String page = "Library";
    final cubit = context.read<LibraryCubit>();
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    cubit.getLibraryBooks(userEmail!);
    return Scaffold(
      backgroundColor: white,
      appBar: _libraryAppBar(context: context),
      bottomNavigationBar: const CustomBottomBar(),
      body: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LibrarySuccess) {
            final data = state.data;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) => _bookBuild(
                    page: page,
                    bookImage: data[index]['imageUrl'],
                    bookName: data[index]['name'],
                    bookAuthor: data[index]['author'],
                    bookRate: data[index]['rate'],
                    context: context),
              ),
            );
          }
          if (state is LibraryFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 50), () {
                Get.Get.snackbar(
                  "Library is Empty",
                  "Nothing found in Library Section",
                  backgroundColor: Colors.white,
                  colorText: Colors.black,
                );
              });
            });
            return const Center(
              child: Text(
                "Tap on add to library for adding to Library",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }
          return const Text("");
        },
      ),
    );
  }
}

AppBar _libraryAppBar({
  required BuildContext context,
}) {
  return AppBar(
    backgroundColor: white,
    title: const Text(
      "Library",
      style: TextStyle(
        color: darkGreen,
        fontWeight: FontWeight.bold,
        fontSize: 27,
      ),
    ),
    centerTitle: true,
  );
}

Widget _bookBuild({
  required String page,
  required String bookImage,
  required String bookName,
  required String bookAuthor,
  required String bookRate,
  bool isPrice = false,
  required BuildContext context,
}) {
  final cubit = context.read<LibraryCubit>();
  return InkWell(
    onTap: () {
      Get.Get.to(
          BookDescription(
            bookName: bookName,
            page: page,
          ),
          transition: Get.Transition.circularReveal,
          duration: const Duration(seconds: 1));
    },
    child: Container(
      height: 240,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                30.0,
              ),
              topRight: Radius.circular(
                30.0,
              ),
            ), // Same border radius as the container
            child: SizedBox(
              height: 130,
              width: 200,
              child: Image.network(
                bookImage,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookName,
                  style: const TextStyle(
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis for overflow
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  bookAuthor,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    isPrice
                        ? Text(
                            "\$ $bookRate",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                bookRate,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        child: const Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          cubit.deleteLibrary(bookName, context);
                          Future.delayed(const Duration(seconds: 1), () {
                            Get.Get.offAll(const Library(),
                                transition: Get.Transition.circularReveal,
                                duration: const Duration(seconds: 1));
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
