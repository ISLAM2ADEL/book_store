import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/category%20cubit/category_cubit.dart';
import 'package:book_store/const.dart';
import 'package:book_store/custom%20bottom%20bar/custom_bottom_bar.dart';
import 'package:book_store/home%20screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'book_category.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getCategories();
    return Scaffold(
      backgroundColor: white,
      appBar: _categoryAppBar(context: context),
      bottomNavigationBar: const CustomBottomBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<CategoryCubit, CategoryState>(
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
                  children: List.generate(29, (index) {
                    return InkWell(
                      child: _categoriesName(categoryName: categories[index]),
                      onTap: () {
                        categoryCubit.getBooks(categories[index]);
                        Get.off(() => BookCategory(
                              category: categories[index],
                            ));
                      },
                    );
                  }),
                );
              }
              return const Text("");
            },
          ),
        ),
      ),
    );
  }

  AppBar _categoryAppBar({
    required BuildContext context,
  }) {
    final cubit = context.read<BottomCubit>();
    return AppBar(
      backgroundColor: white,
      leading: InkWell(
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 26,
        ),
        onTap: () {
          cubit.home();
          Get.off(const Home());
        },
      ),
      title: const Text(
        "Categories",
        style: TextStyle(
          color: darkGreen,
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),
      ),
      centerTitle: true,
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
}
