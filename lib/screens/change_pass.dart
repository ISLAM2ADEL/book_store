import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../const.dart';
import 'package:book_store/cubit/password_cubit_cubit.dart'; // Import your cubit file

class UpdatePass extends StatelessWidget {
  const UpdatePass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: _appBar(context),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  _passField(context, "Old Password", 0),
                  const SizedBox(height: 30),
                  _passField(context, "New Password", 1),
                  const SizedBox(height: 30),
                  _passField(context, "Repeat Password", 2),
                  const SizedBox(height: 50),
                  _updateButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text(
        "Change Password",
        style: TextStyle(
            color: fontColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _passField(BuildContext context, String hint, int index) {
    return BlocBuilder<PasswordCubit, List<bool>>(
      builder: (context, obscurePassword) {
        return TextFormField(
          obscureText: obscurePassword[index],
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF8D8D8D)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            prefixIcon: const Icon(
              CupertinoIcons.lock,
              color: Color(0xFF8D8D8D),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword[index]
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: const Color(0xFF8D8D8D),
              ),
              onPressed: () {
                context.read<PasswordCubit>().togglePasswordVisibility(index);
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _updateButton(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: InkWell(
        onTap: () {
          // Handle update password logic here
        },
        child: Container(
          height: height * 0.07,
          decoration: BoxDecoration(
            color: fontColor,
            borderRadius: BorderRadius.circular(25),
            border: null,
          ),
          child: const Center(
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
