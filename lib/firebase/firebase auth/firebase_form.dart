import 'package:book_store/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../screens/Auth/LogIn_Screen/login_screen.dart';
import '../../screens/Auth/onboarding_screen.dart';
import '../../screens/admin screens/add book/add_book.dart';
import '../../screens/admin screens/admin const.dart';
import '../../screens/home screen/home.dart';

class FirebaseForm {
  Future<void> registerUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Get.snackbar(
        "Email Verification",
        "Please verify your account.",
        backgroundColor: darkGreen,
        colorText: Colors.white,
      );
      Get.to(LoginScreen(),
          transition: Transition.native, duration: const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Error",
          "The password provided is too weak.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Error",
          "The account already exists for that email.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Now signInUser is a class method and accessible.
  Future<void> signInUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offAll(emailAddress == adminEmail ? AddBook() : const Home(),
            transition: Transition.native,
            duration: const Duration(seconds: 1));
      } else {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        Get.snackbar(
          "Email Verification",
          "Please verify your account.",
          backgroundColor: darkGreen,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error",
          "No user found for that email.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          "Wrong password provided for that user.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'invalid-email' ||
          e.code == 'malformed-credential') {
        Get.snackbar(
          "Error",
          "Invalid email or malformed credential provided.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Wrong E-mail or Password please check credentials",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "e.toString()",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signOutUser() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    Get.offAll(const OnboardingScreen());
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    String? userEmail = userCredential.user?.email;
    if (userEmail == adminEmail) {
      Get.offAll(() => AddBook());
    } else {
      Get.offAll(() => const Home());
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Password Changer",
        "Please check your account to reset password.",
        backgroundColor: darkGreen,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Wrong Email",
        "Please check the email you entered.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
