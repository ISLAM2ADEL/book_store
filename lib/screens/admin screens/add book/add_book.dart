import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../book space cubit/admin cubit/add book/image_cubit.dart';
import '../../../const.dart';
import '../../Auth/custom widget/custom_text_form.dart';
import '../admin app bar/admin_app_bar.dart';
import '../admin bottom nav bar/admin_nav_bar.dart';
import 'category_dialog.dart';

class AddBook extends StatelessWidget {
  AddBook({super.key});
  final TextEditingController bookController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
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

                return _buildFormContent(cubit, width, context);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent(
      ImageCubit cubit, double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formBuild(
          text: "Book Name",
          hintText: "e.g. One Piece",
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
          text: "Book Description",
          hintText: "e.g. The King of Pirates Story",
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
          text: "Book Author",
          hintText: "e.g. Ichiro Uda",
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
        const Row(
          children: [
            Text(
              "Book Category",
              style: TextStyle(
                  color: darkGreen, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              " *",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 13,
        ),
        InkWell(
          child: BlocBuilder<ImageCubit, ImageState>(
            builder: (context, state) {
              if (state is ImageCategoryError) {
                return Container(
                  height: 45,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        const Icon(
                          BoxIcons.bx_category,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubit.getCategory(),
                          style: const TextStyle(
                            color: Color(0xFF8D8D8D),
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container(
                height: 45,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      const Icon(
                        BoxIcons.bx_category,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cubit.getCategory(),
                        style: const TextStyle(
                          color: Color(0xFF8D8D8D),
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          onTap: () {
            Get.to(const CategoryDialog());
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Book Price",
          hintText: "e.g. 14.99",
          icons: Icons.attach_money,
          controller: priceController,
          phone: true,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _formBuild(
          text: "Book Rate",
          hintText: "e.g. 4.7",
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              child: BlocBuilder<ImageCubit, ImageState>(
                builder: (context, state) {
                  return Container(
                    height: 38,
                    width: width * .45,
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
                  );
                },
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
            width: width * .8,
            height: 50,
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
            if (addBookFormKey.currentState!.validate() &&
                cubit.getCategory() != "e.g. Adventure") {
              bool isPicked = cubit.getIsPicked();
              if (isPicked) {
                cubit.addBook(
                  bookName: bookController.text,
                  description: descriptionController.text,
                  author: authorController.text,
                  category: cubit.getCategory(),
                  price: priceController.text,
                  rate: rateController.text,
                );
                Get.offAll(AddBook());
                Future.delayed(const Duration(seconds: 3), () {
                  cubit.setCategory("e.g. Adventure");
                });
              } else {
                Get.snackbar(
                  "Image not found",
                  "Please Upload Book Image",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                );
              }
            } else {
              cubit.categoryError();
              Get.snackbar(
                "Fields Empty",
                "Please Fill All Fields",
                colorText: Colors.white,
                backgroundColor: Colors.red,
              );
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
        Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: darkGreen,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 22),
            )
          ],
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
