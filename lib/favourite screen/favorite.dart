import 'package:book_store/Book_description/description.dart';
import 'package:book_store/book%20space%20cubit/favourite%20cubit/favourite_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../book space cubit/bottom cubit/bottom_cubit.dart';
import '../const.dart';
import '../custom bottom bar/custom_bottom_bar.dart';
import '../home screen/home.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    cubit.getFavBooks(userEmail!);
    return Scaffold(
      backgroundColor: white,
      appBar: _favoriteAppBar(context: context),
      bottomNavigationBar: const CustomBottomBar(),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavouriteSuccess) {
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
                    bookImage: data[index]['imageUrl'],
                    bookName: data[index]['name'],
                    bookAuthor: data[index]['author'],
                    bookRate: data[index]['rate'],
                    context: context),
              ),
            );
          }
          if (state is FavouriteFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 50), () {
                Get.snackbar(
                  "Favorite is Empty",
                  "Nothing found in Favorite Section",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              });
            });
            return const Center(
              child: Text(
                "Tap on heart icon for adding to Favorite",
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

AppBar _favoriteAppBar({
  required BuildContext context,
}) {
  final cubit = context.read<BottomCubit>();
  return AppBar(
    backgroundColor: white,
    leading: InkWell(
      child: const Icon(
        Icons.keyboard_backspace_outlined,
        color: Colors.black,
        size: 26,
      ),
      onTap: () {
        cubit.home();
        Get.off(const Home());
      },
    ),
    title: const Text(
      "Favorites",
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
  required String bookImage,
  required String bookName,
  required String bookAuthor,
  required String bookRate,
  bool isPrice = false,
  required BuildContext context,
}) {
  final cubit = context.read<FavouriteCubit>();
  return InkWell(
    onTap: () {
      Get.to(BookDescription(bookName: bookName));
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
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                        ),
                        onTap: () {
                          cubit.deleteFavorite(bookName, context);
                          Future.delayed(const Duration(seconds: 1), () {
                            Get.offAll(const Favorite());
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
