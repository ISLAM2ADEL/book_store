import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/book%20space%20cubit/description%20Cubit/description_cubit.dart';
import 'package:book_store/book%20space%20cubit/library%20cubit/library_cubit.dart';
import 'package:book_store/const.dart';
import 'package:book_store/screens/home%20screen/alphabetic_books.dart';
import 'package:book_store/screens/home%20screen/view_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import '../../book space cubit/home cubit/category cubit/category_cubit.dart';
import '../../book space cubit/home cubit/home_cubit.dart';
import '../category screen/book_category.dart';
import '../category screen/category.dart';
import '../favourite screen/favorite.dart';
import '../home screen/home.dart';
import '../library screens/library.dart';
import '../search screen/search_screen.dart';

class BookDescription extends StatelessWidget {
  final String bookName;
  final String page;

  const BookDescription(
      {super.key, required this.bookName, required this.page});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bottomCubit = context.read<BottomCubit>();
    final categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getCategories();
    final descriptionCubit = context.read<DescriptionCubit>();
    descriptionCubit.getDescription(bookName);
    final libraryCubit = context.read<LibraryCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFF1EEE9),
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.black,
          ),
          onTap: () {
            bottomCubit.home();
            if (page == "Home") {
              Get.Get.off(const Home(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            } else if (page == "Favorite") {
              bottomCubit.favourite();
              Get.Get.off(const Favorite(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            } else if (page == "Library") {
              bottomCubit.myLibrary();
              Get.Get.off(const Library(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            } else if (page == "SearchScreen") {
              Get.Get.off(const SearchScreen(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            } else if (page == "ViewBooks") {
              Get.Get.off(const ViewBooks(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            } else if (page == "AlphabeticBooks") {
              Get.Get.off(const AlphabeticBooks(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            } else {
              bottomCubit.category();
              Get.Get.off(const Category(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            }
          },
        ),
        title: const Text(
          "Detail Book",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocBuilder<DescriptionCubit, DescriptionState>(
            builder: (context, state) {
              if (state is DescriptionLoading) {
                return Transform.translate(
                  offset: Offset(0, height * .5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is DescriptionSuccess) {
                final bookDescription = state.data;
                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 30, left: 30),
                      child: Center(
                        child: Image.network(
                          bookDescription[0]['imageUrl'],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _bookName(bookDescription[0]['name'],
                        bookDescription[0]['author']),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      width: width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _bookInfo("Rating", bookDescription[0]['rate']),
                          _verticalDivider(),
                          _bookInfo("Language", "En"),
                          _verticalDivider(),
                          _bookInfo("Category", bookDescription[0]['category']),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _bookDescription(text: bookDescription[0]['description']),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Tags",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: darkGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Col of hashtags
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CategorySuccess) {
                              final categories = state.data;
                              return Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: List.generate(6, (index) {
                                  return InkWell(
                                    child: _categoriesName(
                                      categoryName: categories[index],
                                    ),
                                    onTap: () {
                                      bottomCubit.category();
                                      Get.Get.off(
                                          () => BookCategory(
                                                category: categories[index],
                                                page: page,
                                              ),
                                          transition:
                                              Get.Transition.circularReveal,
                                          duration: const Duration(seconds: 1));
                                    },
                                  );
                                }),
                              );
                            }
                            return const Text("");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    // Row of similar books
                    const Row(
                      children: [
                        Text(
                          "Popular Books",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: darkGreen,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeBooksLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is HomeBooksSuccess) {
                          final books = state.data;
                          return SizedBox(
                            height: 240,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: books.length,
                              itemBuilder: (context, index) => InkWell(
                                child: _bookBuild(
                                  bookImage: books[index]["imageUrl"],
                                  bookName: books[index]["name"],
                                  bookAuthor: books[index]["author"],
                                  bookRate: books[index]["rate"],
                                  context: context,
                                ),
                                onTap: () {
                                  Get.Get.offAll(
                                      BookDescription(
                                        bookName: books[index]["name"],
                                        page: page,
                                      ),
                                      transition: Get.Transition.circularReveal,
                                      duration: const Duration(seconds: 1));
                                },
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 8,
                              ),
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Reviews",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: darkGreen,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    _buildReviews(
                        "Mysoon Wilson",
                        "Lorem ipsum dolor sit amet, "
                            "consectetur adipiscing elit, sed do eiusmod tempor"
                            " incididunt ut labore et dolore magna aliqua."
                            "Ut enim ad minim veniam",
                        "${path}book.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildReviews(
                        "Mustafa",
                        "Lorem ipsum dolor sit amet, "
                            "consectetur adipiscing elit, sed do eiusmod tempor"
                            " incididunt ut labore et dolore magna aliqua."
                            "Ut enim ad minim veniam",
                        "${path}book2.jpeg"),
                    const SizedBox(
                      height: 30,
                    ),

                    _headLine("Rate A Review"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          "* * * * * ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    _headLine("Write A Review"),

                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 130,
                      //margin: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF1EEE9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: TextFormField(
                        minLines: 1,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          label: Text(
                            "",
                            style: TextStyle(color: Colors.grey),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Container(
                        height: 60,
                        width: width * .8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color(0xFF495346)),
                        child: const Center(
                            child: Text(
                          "Add to Library",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                      ),
                      onTap: () {
                        bottomCubit.myLibrary();
                        libraryCubit.setLibrary(bookName, context);
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.Get.offAll(const Library(),
                              transition: Get.Transition.circularReveal,
                              duration: const Duration(seconds: 1));
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
              return const Text("");
            },
          ),
        ),
      ),
    );
  }

  Row _headLine(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: darkGreen,
          ),
        ),
      ],
    );
  }

  Column _bookDescription({
    required String text,
  }) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: darkGreen,
              ),
            )
          ],
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            //fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Padding _bookInfo(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                text2,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  VerticalDivider _verticalDivider() {
    return const VerticalDivider(
      color: Colors.black,
      thickness: 2,
      indent: 25,
      endIndent: 30,
    );
  }

  Column _bookName(String text1, String text2) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 300,
            child: Center(
              child: Text(
                text1,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            text2,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ]),
      ],
    );
  }

  Container _buildReviews(String name, String text, String image) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(image),
                  radius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [Text("********")],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
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
    return Container(
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
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _categoriesName({
  required String categoryName,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      ("# $categoryName"),
      style: const TextStyle(
        color: darkGreen,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
