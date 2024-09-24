import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const.dart';
import 'onboarding_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.off(() => const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFeae9e5),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Image.asset(
                "${imagePath}images_processed.jpeg",
                fit: BoxFit.cover,
              ), // Correct path to the image
            ),
          ),
        ],
      ),
    );
  }
}
