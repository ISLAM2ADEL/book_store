import 'package:book_store/admin%20screens/admin%20bottom%20nav%20bar/admin_nav_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Auth/custom widget/custom_text_form.dart';
import '../../book space cubit/admin cubit/add book/image_cubit.dart';
import '../../const.dart';
import '../admin app bar/admin_app_bar.dart';

class AddBook extends StatelessWidget {
  AddBook({super.key});
  final TextEditingController bookController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final GlobalKey<FormState> addBookFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<ImageCubit>();

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
            key: addBookFormKey,
            child: BlocBuilder<ImageCubit, ImageState>(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (state is ImageSuccessful) {
                    Get.snackbar(
                      "Success",
                      "Book loaded successfully!",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                    cubit.resetImagePicker();
                  }
                  if (state is ImageFailure) {
                    Get.snackbar(
                      "Failure",
                      state.message,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    cubit.resetImagePicker();
                  }
                });

                if (state is ImageLoading) {
                  return SizedBox(
                    height: height * 0.8, // Adjust as needed
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return _buildFormContent(cubit, width);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent(ImageCubit cubit, double width) {
    return Column(
      children: [
        _formBuild(
          text: "Add Book Name :",
          hintText: "Book Name",
          icons: Icons.book,
          controller: bookController,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Add Book Description :",
          hintText: "Book Description",
          icons: Icons.description,
          controller: descriptionController,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Add Book Author :",
          hintText: "Author's name",
          icons: Icons.drive_file_rename_outline,
          controller: authorController,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Add Book Category :",
          hintText: "Book Category",
          icons: Icons.category,
          controller: categoryController,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Add Book Price :",
          hintText: "Book Price",
          icons: Icons.attach_money,
          controller: priceController,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Add Book Rate :",
          hintText: "Book Rate",
          icons: Icons.star_rate,
          controller: rateController,
          phone: true,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
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
              onTap: () async {
                await cubit.uploadImage();
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
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
          onTap: () async {
            if (addBookFormKey.currentState!.validate()) {
              bool isPicked = cubit.getIsPicked();
              if (isPicked) {
                cubit.addBook(
                  bookName: bookController.text,
                  description: descriptionController.text,
                  author: authorController.text,
                  category: categoryController.text,
                  price: priceController.text,
                  rate: rateController.text,
                );
                Get.offAll(AddBook());
              } else {
                Get.snackbar(
                  "Image not found",
                  "Please Upload Book Image",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                );
              }
            }
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Column _formBuild({
    required String text,
    required String hintText,
    required IconData icons,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    bool phone = false,
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
          isPhone: phone ? true : false,
          hintText: hintText,
          icon: icons,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
