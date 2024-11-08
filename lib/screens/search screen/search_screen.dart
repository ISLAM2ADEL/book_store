import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;

import '../../book space cubit/admin cubit/edit book/edit_cubit.dart';
import '../Book_description/description.dart';
import '../home screen/home.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String page = "SearchScreen";
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF1EEE9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(
                        Icons.keyboard_backspace_outlined,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Get.Get.off(const Home(),
                            transition: Get.Transition.circularReveal,
                            duration: const Duration(seconds: 1));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: _searchBar(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: BlocBuilder<EditCubit, EditState>(
                  builder: (context, state) {
                    if (state is EditLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is EditSuccess) {
                      final data = state.data;
                      // Wrapping the ListView in a SizedBox to avoid layout issues
                      return SizedBox(
                        height: height * 0.8, // Set height constraint
                        child: ListView.separated(
                          itemCount: data.length,
                          itemBuilder: (context, index) => InkWell(
                            child: _bookContainer(
                              height,
                              width,
                              imageUrl: data[index]["imageUrl"],
                              bookName: data[index]["name"],
                              authorName: data[index]["author"],
                              bookCategory: data[index]["category"],
                              bookRate: data[index]["rate"],
                              bookPrice: data[index]["price"],
                              context: context,
                            ),
                            onTap: () {
                              Get.Get.off(
                                  () => BookDescription(
                                        bookName: data[index]['name'],
                                        page: page,
                                      ),
                                  transition: Get.Transition.circularReveal,
                                  duration: const Duration(seconds: 1));
                            },
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                        ),
                      );
                    }
                    return const Text(""); // In case of no data or empty state
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookContainer(
    double height,
    double width, {
    required String imageUrl,
    required String bookName,
    required String authorName,
    required String bookCategory,
    required String bookRate,
    required String bookPrice,
    required BuildContext context,
  }) {
    return Container(
      height: height * .2,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              child: SizedBox(
                height: height * .17,
                width: width * .25,
                child: Image.network(imageUrl),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * .50,
                  child: Text(
                    bookName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  "By $authorName",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                Text(
                  bookCategory,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: width * .55,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            bookRate,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          bookPrice == "0" ? "\$ Free" : "\$ $bookPrice",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    final cubit = context.read<EditCubit>();
    return TextFormField(
      onChanged: (val) {
        cubit.setSearchTerm(val);
        if (val.isEmpty) {
          cubit.getAllBooks();
        } else {
          cubit.getSpecifiedBook(val);
        }
      },
      decoration: InputDecoration(
        hintText: 'Book Name or Title',
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
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
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.35),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
