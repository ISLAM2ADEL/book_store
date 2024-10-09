import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import '../../const.dart';
import '../Book_description/description.dart';
import 'home.dart';

class ViewBooks extends StatelessWidget {
  const ViewBooks({super.key});

  @override
  Widget build(BuildContext context) {
    String page = "ViewBooks";
    return Scaffold(
      backgroundColor: white,
      appBar: _recentAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeBooksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeBooksSuccess) {
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
                    bookPrice: data[index]['price'],
                    context: context),
              ),
            );
          }
          return const Text("");
        },
      ),
    );
  }
}

AppBar _recentAppBar() {
  return AppBar(
    backgroundColor: white,
    leading: InkWell(
      child: const Icon(
        Icons.keyboard_backspace_outlined,
        color: Colors.black,
        size: 26,
      ),
      onTap: () {
        Get.Get.off(() => const Home(),
            transition: Get.Transition.circularReveal,
            duration: const Duration(seconds: 1));
      },
    ),
    title: const Text(
      "All Books",
      style: TextStyle(
        color: darkGreen,
        fontWeight: FontWeight.bold,
        fontSize: 25,
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
  required String bookPrice,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      Get.Get.off(
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
            ),
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
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
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
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 26,
                    ),
                    Text(
                      bookRate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      ("\$ $bookPrice"),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
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
