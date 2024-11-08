import 'package:book_store/book%20space%20cubit/admin%20cubit/add%20book/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../book space cubit/home cubit/category cubit/category_cubit.dart';
import '../../../const.dart';

class CategoryDialog extends StatelessWidget {
  const CategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    final imageCubit = context.read<ImageCubit>();
    categoryCubit.getCategories();
    return Scaffold(
      backgroundColor: white,
      appBar: _categoryAppBar(context: context),
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
                  children: List.generate(categories.length, (index) {
                    return InkWell(
                      child: _categoriesName(categoryName: categories[index]),
                      onTap: () {
                        imageCubit.setCategory(categories[index]);
                        Navigator.pop(context);
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
    return AppBar(
      backgroundColor: white,
      leading: InkWell(
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: darkGreen,
        ),
        onTap: () {
          Navigator.pop(context);
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
