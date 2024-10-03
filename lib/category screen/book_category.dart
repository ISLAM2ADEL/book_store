import 'package:book_store/Book_description/description.dart';
import 'package:book_store/category%20screen/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../book space cubit/home cubit/category cubit/category_cubit.dart';
import '../const.dart';

class BookCategory extends StatelessWidget {
  final String category;
  const BookCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getBooks(category);
    return Scaffold(
      backgroundColor: white,
      appBar: _categoryAppBar(categoryName: category),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18.0),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryBooksLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CategoryBooksSuccess) {
              final books = state.data;
              return ListView.separated(
                itemCount: books.length,
                itemBuilder: (context, index) => InkWell(
                  child: _bookCategory(height, width,
                      bookName: books[index]['name'],
                      bookAuthor: books[index]['author'],
                      bookRate: books[index]['rate'],
                      imageUrl: books[index]['imageUrl']),
                  onTap: () {
                    Get.off(
                        () => BookDescription(bookName: books[index]['name']));
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              );
            }
            return const Text("");
          },
        ),
      )),
    );
  }

  Container _bookCategory(
    double height,
    double width, {
    required String imageUrl,
    required String bookName,
    required String bookAuthor,
    required String bookRate,
  }) {
    return Container(
      height: height * .18,
      width: width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              child: SizedBox(
                height: height * .15,
                width: width * .24,
                child: Image.network(imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * .5,
                    child: Text(
                      bookName,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Text(
                    bookAuthor,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: width * .54,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 24,
                        ),
                        Text(
                          bookRate,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar _categoryAppBar({
  required String categoryName,
}) {
  return AppBar(
    backgroundColor: white,
    leading: InkWell(
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 26,
      ),
      onTap: () {
        Get.off(() => const Category());
      },
    ),
    title: Text(
      "$categoryName Category",
      style: const TextStyle(
        color: darkGreen,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    centerTitle: true,
  );
}
