import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/cubit/edit_profile_cubit.dart';
import 'package:book_store/const.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: backGroundColor,
          leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
          title: const Text("Edit Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              String username = "UserName";
              String email = "aadna@gmail.com";
              File? imgFile;

              if (state is ProfileUpdated) {
                username = state.username;
                email = state.email;
                imgFile = state.imageFile;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    _profileBar(context, imgFile),
                    const SizedBox(height: 20),
                    _buildTextField("Username", username, (value) {
                      //   context.read<EditProfileCubit>().updateUsername(value);
                    }),
                    const SizedBox(height: 20),
                    _buildTextField("Email", email, (value) {
                      // context.read<EditProfileCubit>().updateEmail(value);
                    }),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        //context.read<EditProfileCubit>().updateProfile();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Profile updated!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backGroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Update"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _profileBar(BuildContext context, File? file) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () {
            context.read<EditProfileCubit>().pickImage();
          },
          child: CircleAvatar(
            backgroundImage: (file == null)
                ? AssetImage("${asset}default_profile.png")
                : FileImage(file) as ImageProvider,
            radius: 70,
            backgroundColor: Colors.grey,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              context.read<EditProfileCubit>().pickImage();
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: backGroundColor, width: 2),
              ),
              child: const Icon(
                Icons.edit,
                color: backGroundColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, String initialValue, Function(String) onChanged) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      onChanged: onChanged,
    );
  }
}
