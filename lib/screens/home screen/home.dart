import 'package:book_store/book%20space%20cubit/admin%20cubit/edit%20book/edit_cubit.dart';
import 'package:book_store/book%20space%20cubit/authors%20cubit/author_cubit.dart';
import 'package:book_store/book%20space%20cubit/favourite%20cubit/favourite_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/best%20seller%20cubit/best_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/category%20cubit/category_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:book_store/const.dart';
import 'package:book_store/screens/home%20screen/alphabetic_books.dart';
import 'package:book_store/screens/home%20screen/view_books.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;

import '../../book space cubit/cubit/settings_cubit.dart';
import '../../book space cubit/recent cubit/recent_cubit.dart';
import '../Book_description/description.dart';
import '../category screen/book_category.dart';
import '../custom bottom bar/custom_bottom_bar.dart';
import '../search screen/search_screen.dart';
import '../setting screen/settings_screen.dart';
import 'custom text widget/custom_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    String page = "Home";
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final homeCubit = context.read<HomeCubit>();
    final authorCubit = context.read<AuthorCubit>();
    final bestCubit = context.read<BestCubit>();
    final categoryCubit = context.read<CategoryCubit>();
    final favouriteCubit = context.read<FavouriteCubit>();
    final settingCubit = context.read<SettingsCubit>();
    final recentCubit = context.read<RecentCubit>();
    recentCubit.getRecent();
    homeCubit.getBooksMostPopular();
    bestCubit.getBooksBestSeller();
    categoryCubit.getCategories();
    authorCubit.getAuthors();
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    favouriteCubit.getFavBooks(userEmail!);
    settingCubit.getPhoto(userEmail);
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
              _upperBar(width, context),
              const SizedBox(
                height: 20,
              ),
              _searchField(height, width, context),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Categories"),
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
                          children: List.generate(7, (index) {
                            return InkWell(
                              child: _categoriesName(
                                categoryName: categories[index],
                              ),
                              onTap: () {
                                Get.Get.off(
                                    () => BookCategory(
                                          category: categories[index],
                                          page: page,
                                        ),
                                    transition: Get.Transition.circularReveal,
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
                height: 20,
              ),
              const CustomText(text: "Recent Books"),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: height * .31,
                width: width * .9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<RecentCubit, RecentState>(
                    builder: (context, state) {
                      if (state is RecentLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is RecentSuccess) {
                        final recent = state.data;
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) => _recentBooks(
                            bookImage: recent[index]['imageUrl'],
                            bookText: recent[index]['name'],
                            bookRemaining: "16 h 45 min",
                            height: height,
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                        );
                      }
                      return const Text("");
                    },
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
                            Get.Get.off(const ViewBooks());
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
                            bookRate: books[index]["rate"],
                            context: context,
                          ),
                          onTap: () {
                            Get.Get.off(
                                BookDescription(
                                  bookName: books[index]["name"],
                                  page: page,
                                ),
                                transition: Get.Transition.circularReveal,
                                duration: const Duration(seconds: 1));
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
                            Get.Get.off(const AlphabeticBooks());
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
                            isPrice: true,
                            context: context,
                          ),
                          onTap: () {
                            Get.Get.off(
                                BookDescription(
                                  bookName: books[index]["name"],
                                  page: page,
                                ),
                                transition: Get.Transition.circularReveal,
                                duration: const Duration(seconds: 1));
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
              const CustomText(
                text: "Explore Authors",
                expanded: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 130,
                child: BlocBuilder<AuthorCubit, AuthorState>(
                  builder: (context, state) {
                    if (state is AuthorLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is AuthorSuccess) {
                      bool expand = authorCubit.getExpand();
                      final authors = state.data;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: expand ? authors.length : 10,
                        itemBuilder: (context, index) => _authorBuild(
                          authorName: authors[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Widget _authorBuild({
    required String authorName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black,
            ),
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage("${path}author.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          authorName,
          style: const TextStyle(
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
    bool isFavourite = false,
    required BuildContext context,
  }) {
    final favouriteCubit = context.read<FavouriteCubit>();

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
                            bookRate == "0" ? "\$ Free" : "\$ $bookRate",
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
                    BlocBuilder<FavouriteCubit, FavouriteState>(
                      builder: (context, state) {
                        if (state is FavouriteSuccess) {
                          final book = state.data;
                          for (int i = 0; i < state.data.length; i++) {
                            if (bookName == book[i]['name']) {
                              isFavourite = true;
                            }
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            child: Icon(
                              isFavourite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: Colors.red,
                            ),
                            onTap: () {
                              favouriteCubit.setFavorite(bookName, context);
                              Future.delayed(const Duration(seconds: 1), () {
                                Get.Get.offAll(const Home(),
                                    transition: Get.Transition.circularReveal,
                                    duration: const Duration(seconds: 1));
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )
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
          width: 160,
          child: Row(
            children: [
              SizedBox(
                height: height * .063,
                width: 50,
                child: Image.network(bookImage),
              ),
              SizedBox(
                width: 110,
                child: Text(
                  bookText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 3,
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

  Widget _searchField(height, width, BuildContext context) {
    final editCubit = context.read<EditCubit>();
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
        editCubit.getAllBooks();
        Get.Get.to(() => const SearchScreen(),
            transition: Get.Transition.circularReveal,
            duration: const Duration(seconds: 1));
      },
    );
  }

  Widget _upperBar(width, BuildContext context) {
    String photoUrl = "No profile image found for this user.";
    return Row(
      children: [
        BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingLoading) {
              return const CircularProgressIndicator();
            }
            if (state is SettingSuccess) {
              photoUrl = state.data;
            }
            return CircleAvatar(
              backgroundImage: (photoUrl ==
                      "No profile image found for this user.")
                  ? const AssetImage("${path}Frame_65.png")
                  : NetworkImage(photoUrl)
                      as ImageProvider, // Cast to ImageProvider to avoid type mismatch
              radius: 18,
            );
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
            Icons.settings,
            size: 28,
          ),
          onTap: () {
            Get.Get.off(() => const SettingsScreen(),
                transition: Get.Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
        ),
      ],
    );
  }
}
