import 'package:book_store/Book_description/description.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:book_store/const.dart';
import 'package:book_store/custom%20bottom%20bar/custom_bottom_bar.dart';
import 'package:book_store/firebase/firebase%20auth/firebase_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<HomeCubit>();
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
              _upperBar(),
              const SizedBox(
                height: 20,
              ),
              _searchField(),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textLine(text: "Categories"),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      _categoriesName(categoryName: "Education"),
                      _categoriesName(categoryName: "Fantasy"),
                      _categoriesName(categoryName: "Fiction"),
                      _categoriesName(categoryName: "Novels"),
                      _categoriesName(categoryName: "Adventure"),
                      _categoriesName(categoryName: "Romance"),
                      _categoriesName(categoryName: "Science Fiction"),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _textLine(text: "Recent Books"),
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
                    Choice myChoice = cubit.getChoice();
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
                            cubit.mostPopular();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: _bookType(
                            text: "For You",
                            containerColor: myChoice == Choice.forYou
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myChoice == Choice.forYou
                                ? Colors.white
                                : darkGreen,
                            border: myChoice == Choice.forYou ? false : true,
                          ),
                          onTap: () {
                            cubit.forYou();
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
              SizedBox(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) => InkWell(
                    child: _bookBuild(
                        bookImage: "hunger.png",
                        bookName: "The Hunger",
                        bookAuthor: "Patrick Mauriee",
                        bookRate: "4.5"),
                    onTap: () {
                      Get.to(const BookDescription());
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
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
                    Book myBook = cubit.getBook();
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
                            cubit.bestSeller();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: _bookType(
                            text: "Latest",
                            containerColor: myBook == Book.latest
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myBook == Book.latest
                                ? Colors.white
                                : darkGreen,
                            border: myBook == Book.latest ? false : true,
                          ),
                          onTap: () {
                            cubit.latest();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: _bookType(
                            text: "Coming Soon",
                            containerColor: myBook == Book.comingSoon
                                ? darkGreen
                                : Colors.transparent,
                            textColor: myBook == Book.comingSoon
                                ? Colors.white
                                : darkGreen,
                            border: myBook == Book.comingSoon ? false : true,
                          ),
                          onTap: () {
                            cubit.comingSoon();
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
              SizedBox(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) => _bookBuild(
                    bookImage: "hunger.png",
                    bookName: "The Hunger",
                    bookAuthor: "Patrick Mauriee",
                    bookRate: "22",
                    isPrice: true,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _textLine(text: "Explore Authors"),
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
              child: Image.asset(
                "$path$bookImage",
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
  }) {
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
        const Row(
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
        )
      ],
    );
  }

  Widget _searchField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        prefixIcon: const Icon(
          Icons.search_sharp,
          color: Colors.grey,
        ),
        suffixIcon: Transform.rotate(
          angle: 90 * (3.1416 / 180), // 90 degrees in radians
          child: const Icon(
            CupertinoIcons.slider_horizontal_3,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.35),
          ),
          borderRadius: BorderRadius.circular(30.0), //
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.35),
          ),
          borderRadius: BorderRadius.circular(30.0), //
        ),
        filled: true,
        fillColor: white,
      ),
    );
  }

  Widget _upperBar() {
    FirebaseForm firebaseForm = FirebaseForm();
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage("${path}user image.png"),
        ),
        const SizedBox(
          width: 17,
        ),
        const Text(
          "Hi, Aya!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          child: const Icon(
            Icons.dark_mode_outlined,
            size: 28,
          ),
          onTap: () {
            firebaseForm.signOutUser();
          },
        ),
      ],
    );
  }
}
