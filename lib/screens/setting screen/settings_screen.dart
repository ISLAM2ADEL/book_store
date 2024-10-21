import 'dart:io';

import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Get;
import 'package:icons_plus/icons_plus.dart';
import '../../book space cubit/cubit/settings_cubit.dart';
import '../../firebase/firebase auth/firebase_form.dart';
import '../Auth/Change_Password_Screen/change_password_screen.dart';
import '../favourite screen/favorite.dart';
import '../home screen/home.dart';
import '../library screens/library.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseForm firebaseForm = FirebaseForm();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<SettingsCubit>();
    String? email = cubit.getEmail();
    cubit.getPhoto(email!);

    String photoUrl = "No profile image found for this user.";

    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: InkWell(
          child: const Icon(Icons.keyboard_backspace_outlined),
          onTap: () {
            Get.Get.off(const Home(),
                transition: Get.Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: fontColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 45,
          left: 20,
          right: 20,
        ),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            File? imgFile;

            if (state is SettingsImagePicked) {
              imgFile = state.imageFile;
              context.read<SettingsCubit>().setPhoto(imgFile, email);
            }
            if (state is SettingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SettingSuccess) {
              photoUrl = state.data; // Assign photo URL when available
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileBar(photoUrl, email, width),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      //_buildModelsSection(context),
                      _buildSettingsSection(context, firebaseForm, height),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _profileBar(String file, String? email, double width) {
    return Container(
      height: 80,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: (file == "No profile image found for this user.")
                  ? const AssetImage("${path}Frame_65.png") as ImageProvider
                  : NetworkImage(file), // Use NetworkImage for valid URLs
              radius: 23,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hello !",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Text(
                    email!,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _models(
      {required IconData icons, String? text, required BuildContext context}) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .085,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icons,
              size: 23,
              color: icons == Bootstrap.heart ? Colors.red : Colors.black,
            ),
            const SizedBox(width: 5),
            Text(
              text.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSetting(double height, String text,
      {IconData? icon, String? image, String? value, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * .085,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              image == null ? Icon(icon) : Image.asset(image),
              const SizedBox(width: 10),
              Text(text),
              const Spacer(),
              if (value != null)
                Text(value,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
      BuildContext context, FirebaseForm firebase, double height) {
    final cubit = context.read<BottomCubit>();
    return Column(
      children: [
        InkWell(
          child: _models(
              icons: BoxIcons.bx_book_bookmark,
              text: "Library",
              context: context),
          onTap: () {
            cubit.myLibrary();
            Get.Get.off(const Library(),
                transition: Get.Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          child: _models(
              icons: Bootstrap.heart, text: "Favorites", context: context),
          onTap: () {
            cubit.favourite();
            Get.Get.off(const Favorite(),
                transition: Get.Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
        ),
        const SizedBox(
          height: 28,
        ),
        _buildGeneralSetting(
          height,
          "Change Photo",
          icon: Icons.supervised_user_circle,
          onTap: () {
            context.read<SettingsCubit>().pickImage();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        _buildGeneralSetting(
          height,
          "Change Password",
          image: "${path}solar_password-line-duotone.png",
          onTap: () {
            Get.Get.off(ChangePasswordScreen(),
                transition: Get.Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        _buildGeneralSetting(height, "Log Out", icon: Icons.logout, onTap: () {
          firebase.signOutUser();
        }),
      ],
    );
  }
}
