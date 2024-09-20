import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'LogIn_Screen/LogIn_Screen.dart';
import 'SignUp_Screen/SignUP_Screen.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Start the auto-slide feature
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      int nextPage = _pageController.page!.round() + 1;

      if (nextPage == 2) {
        // assuming you have 2 pages
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        _pageController.animateToPage(nextPage,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
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
              children: [
                OnboardingPage(
                  imageUrl:
                      "https://img.freepik.com/premium-photo/pretty-little-cartoon-girl-reading-book-white-background-generative-ai_849906-2017.jpg?w=740",
                  title: "Welcome To Book World",
                  description:
                      "Finding books can be done through various methods, each offering unique advantages. Public libraries provide extensive \ncollections.",
                ),
                OnboardingPage(
                  imageUrl:
                      "https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/444135292_18267731653236871_7864359005923533026_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHHYEYkUCzIhuGXKzMtuMa9ijbsa3VxE8eKNuxrdXETx6GxjCwE8cBSPlxtVgrAMqdZ-Lysmk0jw7u9QQkN_D23&_nc_ohc=TotABRAHOYIQ7kNvgGOkLkW&_nc_ht=scontent-hbe1-1.xx&_nc_gid=AObO06HwS7KxtRalyVl5ZWe&oh=00_AYDzFDILpIxguUIPi_fUbdP-6_cgJi4YVttgGwU1_X5j7w&oe=66EE45C0",
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
            effect: ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 10,
              dotColor: Colors.grey,
              activeDotColor: Color(0xFF475144),
            ),
          ),
          SizedBox(height: height * 0.06),
          InkWell(
            onTap: () {
              Get.to(SignupScreen());
            },
            child: CreateAccContainer(
              fontColor: Colors.white,
              height: height * 0.06,
              width: width * 0.87,
              text: "Create New Account",
              color: Color(0xFF475144),
              isBorder: false,
            ),
          ),
          SizedBox(height: height * 0.03),
          InkWell(
            onTap: () {
              Get.to(LoginScreen());
            },
            child: CreateAccContainer(
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

  Container CreateAccContainer({
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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(177),
              bottomRight: Radius.circular(177),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fitHeight,
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
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
