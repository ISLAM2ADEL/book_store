import 'package:book_store/Auth/SignUp_Screen/sign_up_screen.dart';
import 'package:book_store/Auth/onboarding_screen.dart';
import 'package:book_store/book%20space%20cubit/form%20cubit/text_form_cubit.dart';
import 'package:book_store/home%20screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

import '../custom widget/custom_text_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = context.read<TextFormCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFF1EEE9),
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF3E463B),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF1EEE9),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.to(const OnboardingScreen());
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
                SizedBox(
                  height: height * 0.07,
                ),
                // Email TextFormField
                CustomTextForm(
                  hintText: "Email",
                  controller: emailController,
                  icon: CupertinoIcons.mail,
                  isEmail: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Regex for email validation
                    final regex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!regex.hasMatch(val)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password TextFormField
                CustomTextForm(
                  hintText: "Password",
                  controller: passwordController,
                  icon: CupertinoIcons.lock,
                  isPassword: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your password';
                    }
                    // Password validation
                    if (val.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (!RegExp(r'(?=.*\d)').hasMatch(val)) {
                      return 'Password must contain at least one digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Remember me and Forget Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BlocBuilder<TextFormCubit, TextFormState>(
                          builder: (context, state) {
                            bool rememberMe = cubit.getRememberMe();
                            return Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                cubit.changeRememberMe();
                              },
                            );
                          },
                        ),
                        const Text("Remember me"),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        if (emailController.text == "") {
                          Get.snackbar(
                              "Empty Email field", "Please Fill Email Field ",
                              barBlur: 30);
                        } else {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailController.text);
                          } catch (e) {
                            print(e);
                          }
                          ;

                          Get.snackbar("Reset Password", "Check Your Inbox",
                              barBlur: 30);
                        }
                      },
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // Login Button
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          if (credential.user!.emailVerified) {
                            Get.offAll(() => const Home());
                          } else {
                            Get.snackbar('Error', 'Verify Your Email.');
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      }
                    },
                    child: createAccContainer(
                      fontColor: Colors.white,
                      height: height * 0.06,
                      width: width * 0.87,
                      text: "Login",
                      color: const Color(0xFF3E463B),
                      isBorder: false,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Social Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Bootstrap.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: const Icon(
                        Bootstrap.google,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: const Text(
                        "Sign Up",
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

Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) {
    return;
  }
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);
  Get.offAll(const Home());
}
