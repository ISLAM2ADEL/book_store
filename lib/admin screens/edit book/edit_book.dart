import 'package:book_store/Auth/custom%20widget/custom_text_form.dart';
import 'package:book_store/admin%20screens/admin%20app%20bar/admin_app_bar.dart';
import 'package:book_store/admin%20screens/edit%20book/delete_book_page.dart';
import 'package:book_store/admin%20screens/edit%20book/edit_book_page.dart';
import 'package:book_store/book%20space%20cubit/admin%20cubit/edit%20book/edit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../const.dart';
import '../admin bottom nav bar/admin_nav_bar.dart';

class EditBook extends StatelessWidget {
  EditBook({super.key});
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<EditCubit>();
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: const AdminNavBar(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AdminAppBar(),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: width * .9,
              height: height * .075,
              child: CustomTextForm(
                controller: search,
                hintText: "Search",
                icon: Icons.search,
                onChangedSearch: true,
                onChanged: (val) {
                  cubit.setSearchTerm(val);
                  if (val.isEmpty) {
                    cubit.getAllBooks();
                  } else {
                    cubit.getSpecifiedBook(val);
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: BlocBuilder<EditCubit, EditState>(
                  builder: (context, state) {
                    if (state is EditLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is EditSuccess) {
                      final data = state.data;
                      return ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) => _bookContainer(
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
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ],
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
    final cubit = context.read<EditCubit>();
    return Container(
      height: height * .2,
      width: width * .9,
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  15.0,
                ),
                topRight: Radius.circular(
                  15.0,
                ),
                bottomLeft: Radius.circular(
                  15.0,
                ),
                bottomRight: Radius.circular(
                  15.0,
                ),
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
                  width: width * .55,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 105,
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
                      const Spacer(),
                      InkWell(
                        child: _editBoxes(
                            colors: Colors.orangeAccent, icons: Icons.edit),
                        onTap: () {
                          cubit.getBookData(bookName);
                          Get.to(EditBookPage());
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child:
                            _editBoxes(colors: Colors.red, icons: Icons.delete),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteBookPage(bookName: bookName);
                              });
                        },
                      ),
                    ],
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
                      Text(
                        "\$ $bookPrice",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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

  Widget _editBoxes({
    required IconData icons,
    required Color colors,
  }) {
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: colors),
        color: Colors.transparent,
      ),
      child: Center(
        child: Icon(
          icons,
          color: colors,
        ),
      ),
    );
  }
}
