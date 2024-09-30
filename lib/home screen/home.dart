import 'package:book_store/Book_description/description.dart';
import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/best%20seller%20cubit/best_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/category%20cubit/category_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:book_store/category%20screen/category.dart';
import 'package:book_store/const.dart';
import 'package:book_store/custom%20bottom%20bar/custom_bottom_bar.dart';
import 'package:book_store/search%20screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../screens/settings_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final homeCubit = context.read<HomeCubit>();
    final bestCubit = context.read<BestCubit>();
    final categoryCubit = context.read<CategoryCubit>();
    homeCubit.getBooksMostPopular();
    bestCubit.getBooksBestSeller();
    categoryCubit.getCategories();
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: height * .06,
            left: width * .055,
            right: width * .055,
          ),
          child: Column(
            children: [
              _upperBar(width),
              const SizedBox(
                height: 20,
              ),
              _searchField(height, width),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textLine(text: "Categories", context: context),
                  const SizedBox(
                    height: 20,
                  ),
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
                          children: [
                            _categoriesName(categoryName: categories[0]),
                            _categoriesName(categoryName: categories[1]),
                            _categoriesName(categoryName: categories[2]),
                            _categoriesName(categoryName: categories[3]),
                            _categoriesName(categoryName: categories[4]),
                            _categoriesName(categoryName: categories[5]),
                          ],
                        );
                      }
                      return const GetSnackBar();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _textLine(text: "Recent Books", context: context),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: height * .30,
                width: width * .9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _recentBooks(
                        bookImage: "hamlet.png",
                        bookText: "Hamlet",
                        bookRemaining: "16 h 45 min",
                        height: height,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _recentBooks(
                        bookImage: "the island.png",
                        bookText: "The island",
                        bookRemaining: "16 h 45 min",
                        height: height,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _recentBooks(
                        bookImage: "hunger.png",
                        bookText: "Hunger",
                        bookRemaining: "16 h 45 min",
                        height: height,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    Choice myChoice = homeCubit.getChoice();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: _bookType(
                            text: "Most popular",
                            containerColor: myChoice == Choice.mostPopular
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myChoice == Choice.mostPopular
                                ? Colors.white
                                : darkGreen,
                            border:
                                myChoice == Choice.mostPopular ? false : true,
                          ),
                          onTap: () {
                            homeCubit.mostPopular();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: _bookType(
                            text: "All Books",
                            containerColor: myChoice == Choice.allBooks
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myChoice == Choice.allBooks
                                ? Colors.white
                                : darkGreen,
                            border: myChoice == Choice.allBooks ? false : true,
                          ),
                          onTap: () {
                            homeCubit.forYou();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
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
                              bookRate: books[index]["rate"]),
                          onTap: () {
                            Get.to(const BookDescription());
                          },
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
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
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<BestCubit, BestState>(
                  builder: (context, state) {
                    Book myBook = bestCubit.getBook();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: _bookType(
                            text: "Best Seller",
                            containerColor: myBook == Book.bestSeller
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myBook == Book.bestSeller
                                ? Colors.white
                                : darkGreen,
                            border: myBook == Book.bestSeller ? false : true,
                          ),
                          onTap: () {
                            bestCubit.bestSeller();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: _bookType(
                            text: "Alphabetic",
                            containerColor: myBook == Book.alphabetic
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myBook == Book.alphabetic
                                ? Colors.white
                                : darkGreen,
                            border: myBook == Book.alphabetic ? false : true,
                          ),
                          onTap: () {
                            bestCubit.alphabetic();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: _bookType(
                            text: "Free",
                            containerColor: myBook == Book.free
                                ? darkGreen
                                : Colors.transparent,
                            textColor:
                                myBook == Book.free ? Colors.white : darkGreen,
                            border: myBook == Book.free ? false : true,
                          ),
                          onTap: () {
                            bestCubit.freeBooks();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<BestCubit, BestState>(
                builder: (context, state) {
                  if (state is BestLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is BestSuccess) {
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
                              bookRate: books[index]["price"],
                              isPrice: true),
                          onTap: () {
                            Get.to(const BookDescription());
                          },
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
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
              _textLine(text: "Explore Authors", context: context),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) => _authorBuild(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Widget _authorBuild() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              radius: 54,
              backgroundColor: Colors.black,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("${path}author.png"),
            ),
          ],
        ),
        Text(
          "Dana Thomas",
          style: TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget _bookBuild({
    required String bookImage,
    required String bookName,
    required String bookAuthor,
    required String bookRate,
    bool isPrice = false,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookType({
    required String text,
    required Color containerColor,
    required Color textColor,
    bool border = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(30),
        border: border ? Border.all(color: darkGreen, width: 1.7) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _recentBooks({
    required String bookImage,
    required String bookText,
    required String bookRemaining,
    required double height,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Row(
            children: [
              SizedBox(
                height: height * .063,
                width: 50,
                child: Image.asset("$path$bookImage"),
              ),
              Text(
                bookText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 35,
        ),
        Column(
          children: [
            const Text(
              "Remaining",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              bookRemaining,
              style: const TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.timelapse_outlined,
          color: darkGreen,
        ),
      ],
    );
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
        categoryName,
        style: const TextStyle(
          color: darkGreen,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _textLine({
    required String text,
    required BuildContext context,
  }) {
    final homecubit = context.read<BottomCubit>();
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          child: const Row(
            children: [
              Text(
                "See All",
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 25,
                color: darkGreen,
              )
            ],
          ),
          onTap: () {
            if (text == "Categories") {
              homecubit.category();
              Get.off(const Category());
            }
          },
        )
      ],
    );
  }

  Widget _searchField(height, width) {
    return InkWell(
      child: Container(
        height: height * .06,
        width: width * .9,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: grey,
              ),
              SizedBox(
                width: width * .05,
              ),
              const Text(
                "Search",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              Transform.rotate(
                angle: 90 * (3.1416 / 180),
                child: const Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(() => const SearchScreen());
      },
    );
  }

  Widget _upperBar(width) {
    return Row(
      children: [
        InkWell(
          child: const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage("${path}user image.png"),
          ),
          onTap: () {
            Get.off(const SettingsScreen());
          },
        ),
        SizedBox(
          width: width * .20,
        ),
        const Text(
          "Book Space",
          style: TextStyle(
            color: Color(0xFF3E463B),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        InkWell(
          child: const Icon(
            Icons.dark_mode_outlined,
            size: 28,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
