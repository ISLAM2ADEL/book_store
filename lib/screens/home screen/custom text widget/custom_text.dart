import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import '../../../book space cubit/authors cubit/author_cubit.dart';
import '../../../book space cubit/bottom cubit/bottom_cubit.dart';
import '../../../const.dart';
import '../../category screen/category.dart';
import '../../recent screen/recent.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool expanded;

  const CustomText({
    super.key,
    required this.text,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<BottomCubit>();
    final authorCubit = context.read<AuthorCubit>();
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
        InkWell(
          child: Row(
            children: [
              BlocBuilder<AuthorCubit, AuthorState>(
                builder: (context, state) {
                  bool expand = authorCubit.getExpand();
                  return Text(
                    expand && expanded ? "See Less" : "See All",
                    style: const TextStyle(
                      color: darkGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
              const Icon(
                Icons.chevron_right,
                size: 25,
                color: darkGreen,
              )
            ],
          ),
          onTap: () {
            if (text == "Categories") {
              homeCubit.category();
              Get.Get.off(() => const Category(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            }
            if (text == "Explore Authors") {
              authorCubit.expandAuthors();
            }
            if (text == "Recent Books") {
              Get.Get.off(const Recent(),
                  transition: Get.Transition.circularReveal,
                  duration: const Duration(seconds: 1));
            }
          },
        )
      ],
    );
  }
}
