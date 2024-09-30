import 'package:book_store/home%20screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../LogIn_Screen/login_screen.dart';
import '../custom widget/custom_text_form.dart';
import '../forget_screen/Cubit/forget_cubit.dart';
import '../forget_screen/Cubit/forget_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
    }

    return BlocProvider(
      create: (context) => ForgetPasswordCubit(), // Provide the Cubit
      child: Scaffold(
        backgroundColor: const Color(0xFFF1EEE9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1EEE9),
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Get.to(const Home());
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF3E463B),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * .1),
                  const Text(
                    "Change \nPassword ?",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF3E463B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  // Email TextFormField (Pre-filled and disabled)
                  CustomTextForm(
                    hintText: "Enter Your Email",
                    controller: emailController,
                    icon: CupertinoIcons.mail,
                    isEmail: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email';
                      }
                      final regex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!regex.hasMatch(val)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  CustomTextForm(
                    hintText: "Enter Current Password",
                    controller: currentPasswordController,
                    icon: CupertinoIcons.lock,
                    isEmail: false,
                    isPassword: true,
                    // Enable password hiding
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  CustomTextForm(
                    hintText: "Enter New Password",
                    controller: newPasswordController,
                    icon: CupertinoIcons.lock,
                    isEmail: false,
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your new password';
                      }
                      if (val.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),

                  BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordSuccess) {
                        Get.snackbar(
                            "Password Change", "Password updated successfully",
                            barBlur: 30);
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.off(() => LoginScreen());
                        });
                      } else if (state is ForgetPasswordFailure) {
                        Get.snackbar("Error", state.error, barBlur: 30);
                      }
                    },
                    builder: (context, state) {
                      if (state is ForgetPasswordLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                AuthCredential credential =
                                    EmailAuthProvider.credential(
                                  email: emailController.text,
                                  password: currentPasswordController.text,
                                );

                                await user
                                    ?.reauthenticateWithCredential(credential);

                                await user?.updatePassword(
                                    newPasswordController.text);

                                Get.snackbar(
                                    "Success", "Password updated successfully",
                                    barBlur: 30);
                              } on FirebaseAuthException catch (e) {
                                Get.snackbar("Error",
                                    e.message ?? 'Password update failed',
                                    barBlur: 30);
                              }
                            }
                          },
                          child: createAccContainer(
                            fontColor: Colors.white,
                            height: height * 0.06,
                            width: width * 0.87,
                            text: "Update Password",
                            color: const Color(0xFF3E463B),
                            isBorder: false,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
