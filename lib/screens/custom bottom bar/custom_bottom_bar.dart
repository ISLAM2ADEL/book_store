import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import 'package:icons_plus/icons_plus.dart';

import '../category screen/category.dart';
import '../favourite screen/favorite.dart';
import '../home screen/home.dart';
import '../library screens/library.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BottomCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: BlocBuilder<BottomCubit, BottomState>(
        builder: (context, state) {
          Bar myChoice = cubit.getBarChoice();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: _bottomNavButtons(
                  icons: Bootstrap.house,
                  text: "Home",
                  bottomColor:
                      myChoice == Bar.home ? Colors.black : Colors.grey,
                ),
                onTap: () {
                  cubit.home();
                  Get.Get.off(() => const Home(),
                      transition: Get.Transition.noTransition,
                      duration: const Duration(seconds: 1));
                },
              ),
              InkWell(
                child: _bottomNavButtons(
                  icons: Bootstrap.heart,
                  text: "Favourite",
                  bottomColor:
                      myChoice == Bar.favourite ? Colors.black : Colors.grey,
                ),
                onTap: () {
                  Get.Get.off(() => const Favorite(),
                      transition: Get.Transition.noTransition,
                      duration: const Duration(seconds: 1));
                  cubit.favourite();
                },
              ),
              InkWell(
                child: _bottomNavButtons(
                  icons: BoxIcons.bx_category,
                  text: "Category",
                  bottomColor:
                      myChoice == Bar.category ? Colors.black : Colors.grey,
                ),
                onTap: () {
                  cubit.category();
                  Get.Get.off(() => const Category(),
                      transition: Get.Transition.noTransition,
                      duration: const Duration(seconds: 1));
                },
              ),
              InkWell(
                child: _bottomNavButtons(
                  icons: BoxIcons.bx_book_bookmark,
                  text: "My Library",
                  bottomColor:
                      myChoice == Bar.myLibrary ? Colors.black : Colors.grey,
                ),
                onTap: () {
                  cubit.myLibrary();
                  Get.Get.off(() => const Library(),
                      transition: Get.Transition.noTransition,
                      duration: const Duration(seconds: 1));
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Column _bottomNavButtons({
    required IconData icons,
    required String text,
    required Color bottomColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icons,
          color: bottomColor,
          size: 27,
        ),
        Text(
          text,
          style: TextStyle(
            color: bottomColor,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
