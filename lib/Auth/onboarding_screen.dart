import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../const.dart';
import 'LogIn_Screen/login_screen.dart';
import 'SignUp_Screen/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Start the auto-slide feature
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage = _pageController.page!.round() + 1;

      if (nextPage == 2) {
        // assuming you have 2 pages
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      } else {
        _pageController.animateToPage(nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                OnboardingPage(
                  imageUrl: "onboarding1.jpeg",
                  title: "Welcome To Book World",
                  description:
                      "Finding books can be done through various methods, each offering unique advantages. Public libraries provide extensive \ncollections.",
                ),
                OnboardingPage(
                  imageUrl: "onboarding2.jpeg",
                  title: "AnyTime, AnyWhere",
                  description:
                      "Finding books can be done through various methods, each offering unique advantages. Public libraries provide extensive \ncollections.",
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          SmoothPageIndicator(
            controller: _pageController,
            count: 2,
            effect: const ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 10,
              dotColor: Colors.grey,
              activeDotColor: Color(0xFF475144),
            ),
          ),
          SizedBox(height: height * 0.06),
          InkWell(
            onTap: () {
              Get.to(SignUpScreen());
            },
            child: createAccContainer(
              fontColor: Colors.white,
              height: height * 0.06,
              width: width * 0.87,
              text: "Create New Account",
              color: const Color(0xFF475144),
              isBorder: false,
            ),
          ),
          SizedBox(height: height * 0.03),
          InkWell(
            onTap: () {
              Get.to(LoginScreen());
            },
            child: createAccContainer(
              fontColor: Colors.black,
              height: height * 0.06,
              width: width * 0.87,
              text: "Login",
              color: Colors.white,
              isBorder: true,
            ),
          ),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
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
}

class OnboardingPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(177),
              bottomRight: Radius.circular(177),
            ),
            child: Image.asset(
              "$path$imageUrl",
              fit: BoxFit.fitHeight,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
