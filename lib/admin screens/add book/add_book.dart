import 'package:book_store/admin%20screens/admin%20bottom%20nav%20bar/admin_nav_bar.dart';
import 'package:book_store/firebase/firebase%20auth/firebase_form.dart';
import 'package:book_store/firebase/firebase%20book/firebase_book.dart';
import 'package:flutter/material.dart';

import '../../Auth/custom widget/custom_text_form.dart';
import '../../const.dart';
import '../admin app bar/admin_app_bar.dart';

class AddBook extends StatelessWidget {
  AddBook({super.key});
  final TextEditingController _bookController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final GlobalKey<FormState> _addBookFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    FirebaseBook firebaseBook = FirebaseBook();
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: const AdminNavBar(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AdminAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child: Form(
            key: _addBookFormKey,
            child: Column(
              children: [
                _formBuild(
                    text: "Add Book Name :",
                    hintText: "Book Name",
                    icons: Icons.book,
                    controller: _bookController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field can not be empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                _formBuild(
                    text: "Add Book Description :",
                    hintText: "Book Description",
                    icons: Icons.description,
                    controller: _descriptionController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field can not be empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                _formBuild(
                    text: "Add Book Author :",
                    hintText: "Author's name",
                    icons: Icons.drive_file_rename_outline,
                    controller: _authorController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field can not be empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                _formBuild(
                    text: "Add Book Category :",
                    hintText: "Book Category",
                    icons: Icons.category,
                    controller: _categoryController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field can not be empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                _formBuild(
                    text: "Add Book Price :",
                    hintText: "Book Price",
                    icons: Icons.attach_money,
                    controller: _priceController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field can not be empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                _formBuild(
                    text: "Add Book Rate :",
                    hintText: "Book Rate",
                    icons: Icons.star_rate,
                    controller: _rateController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "This field can not be empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Book Image :",
                      style: TextStyle(
                        color: darkGreen,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        width: width * .5,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: darkGreen, width: 2.0),
                        ),
                        child: const Center(
                          child: Text(
                            "Upload Image",
                            style: TextStyle(
                              color: darkGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        firebaseBook.addImage();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    child: Container(
                      width: width * .85,
                      height: 65,
                      decoration: BoxDecoration(
                        color: darkGreen,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Book",
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_addBookFormKey.currentState!.validate()) {
                        print("Book Added");
                      }
                    }),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _formBuild({
    required String text,
    required String hintText,
    required IconData icons,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 13),
        CustomTextForm(
          hintText: hintText,
          icon: icons,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
