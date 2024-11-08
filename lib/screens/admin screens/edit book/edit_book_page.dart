import 'package:book_store/book%20space%20cubit/admin%20cubit/edit%20book/edit_cubit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../book space cubit/admin cubit/add book/image_cubit.dart';
import '../../../const.dart';
import '../../Auth/custom widget/custom_text_form.dart';
import 'edit_book.dart';

class EditBookPage extends StatelessWidget {
  EditBookPage({super.key});
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
    final editCubit = context.read<EditCubit>();
    cubit.update();
    bool updated = cubit.getUpdated();

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: InkWell(
          child: const Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.black,
            size: 25,
          ),
          onTap: () {
            editCubit.getAllBooks();
            Get.offAll(EditBook());
          },
        ),
        title: const Text(
          "Edit Book",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<EditCubit, EditState>(
        listener: (context, state) {
          if (state is EditDataSuccess) {
            bookController.text = state.data[0]['name'];
            descriptionController.text = state.data[0]['description'];
            authorController.text = state.data[0]['author'];
            categoryController.text = state.data[0]['category'];
            priceController.text = state.data[0]['price'];
            rateController.text = state.data[0]['rate'];
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Form(
              key: addBookFormKey,
              child: BlocBuilder<ImageCubit, ImageState>(
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (state is ImageUpdateSuccessful && updated) {
                      Get.snackbar(
                        "Success",
                        "Book Updated successfully!",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      cubit.resetUpdate();
                    }
                    if (state is ImageUpdateFailure) {
                      Get.snackbar(
                        "Failure",
                        state.message,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  });

                  if (state is ImageUpdateLoading) {
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
      ),
    );
  }

  Widget _buildFormContent(ImageCubit cubit, double width) {
    return Column(
      children: [
        _formBuild(
          check: true,
          text: "Update Book Name :",
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
          text: "Update Book Description :",
          hintText: "Book Description",
          icons: Icons.description,
          isMax: true,
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
          text: "Update Book Author :",
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
          text: "Update Book Category :",
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
          text: "Update Book Price :",
          isPhone: true,
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
          text: "Update Book Rate :",
          isPhone: true,
          hintText: "Book Rate",
          icons: Icons.star_rate,
          controller: rateController,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can not be empty";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
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
                "Update Book",
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
              cubit.updateBook(
                bookName: bookController.text,
                description: descriptionController.text,
                author: authorController.text,
                category: categoryController.text,
                price: priceController.text,
                rate: rateController.text,
              );
              Get.offAll(EditBookPage());
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
    bool check = false,
    bool isMax = false,
    bool isPhone = false,
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
          isRead: check,
          isMax: isMax ? true : false,
          isPhone: isPhone ? true : false,
          hintText: hintText,
          icon: icons,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
