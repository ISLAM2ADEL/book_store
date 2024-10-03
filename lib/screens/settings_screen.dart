import 'dart:io';
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
            child: const Icon(Icons.arrow_back_ios),
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
      height: 100,
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
                "UserName",
                style: TextStyle(fontWeight: FontWeight.w300, color: fontColor),
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
      height: height * .2, // Set a fixed height for models
      child: Column(
        children: [
          Row(
            children: [
              _models(
                  context: context,
                  image: "solar_bag-smile-bold-duotone.png",
                  text: "Orders"),
              const SizedBox(width: 10),
              _models(
                  image: "solar_library-bold-duotone.png",
                  text: "Library",
                  context: context),
            ],
          ),
          const SizedBox(height: 10), // Space between rows
          Row(
            children: [
              _models(
                  image: "solar_heart-bold.png",
                  text: "Wish List",
                  context: context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _models({String? image, String? text, required BuildContext context}) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        height: height * .07,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
            color: fontColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("$path$image"),
            const SizedBox(width: 5),
            Text(
              text.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
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
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            image == null ? Icon(icon) : Image.asset(image),
            const SizedBox(width: 10),
            Text(text),
            const Spacer(),
            if (value != null)
              Text(value,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 20,
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _buildSettingsSection(BuildContext context, FirebaseForm firebase) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "General Settings",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: fontColor),
          ),
        ),
        _buildGeneralSetting(
          "Change Photo",
          icon: Icons.supervised_user_circle,
          onTap: () {
            context.read<SettingsCubit>().pickImage();
          },
        ),
        _buildDivider(),
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
        _buildDivider(),
        _buildGeneralSetting(
          "Language",
          image: "${path}tabler_language.png",
          value: "English",
        ),
        _buildDivider(),
        _buildGeneralSetting(
          "Theme",
          icon: Icons.dark_mode,
          value: "Lite",
        ),
        _buildDivider(),
        _buildGeneralSetting("Log Out", icon: Icons.logout, onTap: () {
          firebase.signOutUser();
        }),
      ],
    );
  }
}
