import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BottomCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        height: 80,
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
                    icons: CupertinoIcons.home,
                    text: "Home",
                    bottomColor:
                        myChoice == Bar.home ? Colors.black : Colors.grey,
                  ),
                  onTap: () {
                    cubit.home();
                  },
                ),
                InkWell(
                  child: _bottomNavButtons(
                    icons: CupertinoIcons.heart,
                    text: "Favourite",
                    bottomColor:
                        myChoice == Bar.favourite ? Colors.black : Colors.grey,
                  ),
                  onTap: () {
                    cubit.favourite();
                  },
                ),
                InkWell(
                  child: _bottomNavButtons(
                    icons: Icons.category_outlined,
                    text: "Category",
                    bottomColor:
                        myChoice == Bar.category ? Colors.black : Colors.grey,
                  ),
                  onTap: () {
                    cubit.category();
                  },
                ),
                InkWell(
                  child: _bottomNavButtons(
                    icons: Icons.book_outlined,
                    text: "My Library",
                    bottomColor:
                        myChoice == Bar.myLibrary ? Colors.black : Colors.grey,
                  ),
                  onTap: () {
                    cubit.myLibrary();
                  },
                ),
              ],
            );
          },
        ),
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
          size: 42,
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