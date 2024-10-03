import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/category%20screen/category.dart';
import 'package:book_store/home%20screen/home.dart';
import 'package:book_store/library%20screens/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../favourite screen/favorite.dart';

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
                  Get.off(() => const Home());
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
                  Get.off(() => const Favorite());
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
                  Get.off(() => const Category());
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
                  Get.off(() => const Library());
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
