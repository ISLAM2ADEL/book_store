import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../LogIn_Screen/login_screen.dart';
import '../custom widget/custom_text_form.dart';
import 'Cubit/forget_cubit.dart';
import 'Cubit/forget_state.dart';

class ForgetScreen extends StatelessWidget {
  ForgetScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ForgetPasswordCubit(), // Provide the Cubit
      child: Scaffold(
        backgroundColor: const Color(0xFFF1EEE9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1EEE9),
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Get.to(LoginScreen());
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
                    "Forgot \nPassword ?",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF3E463B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  // Email TextFormField
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
                  const SizedBox(height: 50),

                  BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordSuccess) {
                        Get.snackbar("Reset Password", "Check Your Inbox",
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
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .sendPasswordResetEmail(
                                    emailController.text,
                                  );
                            }
                          },
                          child: createAccContainer(
                            fontColor: Colors.white,
                            height: height * 0.06,
                            width: width * 0.87,
                            text: "Reset Password",
                            color: const Color(0xFF3E463B),
                            isBorder: false,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Back to login?"),
                      TextButton(
                        onPressed: () {
                          Get.off(() => LoginScreen());
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF475144),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Container createAccContainer({
  required double height,
  required double width,
  required String text,
  required Color? color,
  required Color? fontColor,
  required bool isBorder,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
      border: isBorder ? Border.all() : null,
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    ),
  );
}
