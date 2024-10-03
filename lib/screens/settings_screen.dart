import 'dart:io';
import 'package:book_store/favourite%20screen/favorite.dart';
import 'package:book_store/library%20screens/library.dart';
import 'package:book_store/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/const.dart';
import 'package:book_store/cubit/settings_cubit.dart';
import 'package:get/get.dart';

import '../Auth/Change_Password_Screen/change_password_screen.dart';
import '../firebase/firebase auth/firebase_form.dart';
import '../home screen/home.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseForm firebaseForm = FirebaseForm();
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: backGroundColor,
          leading: InkWell(
            child: const Icon(Icons.keyboard_backspace_outlined),
            onTap: () {
              Get.off(const Home());
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
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              File? imgFile;

              if (state is SettingsImagePicked) {
                imgFile = state.imageFile;
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()));
                          },
                          child: _profileBar(imgFile)),
                    ),
                    _buildModelsSection(context),
                    _buildSettingsSection(context, firebaseForm),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _profileBar(File? file) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: (file == null)
                ? const AssetImage("${path}Frame_65.png")
                : FileImage(file) as ImageProvider,
            radius: 23,
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "UserEmail",
                style:
                    TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
              ),
              Text(
                "aadna@gmail.com",
                style:
                    TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }

  Widget _buildModelsSection(dynamic context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * .168, // Set a fixed height for models
      child: Column(
        children: [
          InkWell(
            child: _models(
                image: "solar_library-bold-duotone.png",
                text: "Library",
                context: context),
            onTap: () {
              Get.off(const Library());
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: _models(
                image: "solar_heart-bold.png",
                text: "Wish List",
                context: context),
            onTap: () {
              Get.off(const Favorite());
            },
          ),
        ],
      ),
    );
  }

  Widget _models({String? image, String? text, required BuildContext context}) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .065,
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
            Image.asset("$path$image"),
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

  Widget _buildGeneralSetting(String text,
      {IconData? icon, String? image, String? value, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
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

  Widget _buildSettingsSection(BuildContext context, FirebaseForm firebase) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        _buildGeneralSetting(
          "Change Photo",
          icon: Icons.supervised_user_circle,
          onTap: () {
            context.read<SettingsCubit>().pickImage();
          },
        ),
        _buildGeneralSetting(
          "Change Password",
          image: "${path}solar_password-line-duotone.png",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen()));
          },
        ),
        _buildGeneralSetting(
          "Theme",
          icon: Icons.dark_mode,
          value: "Lite",
        ),
        _buildGeneralSetting("Log Out", icon: Icons.logout, onTap: () {
          firebase.signOutUser();
        }),
      ],
    );
  }
}
