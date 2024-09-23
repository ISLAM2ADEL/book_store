import 'package:book_store/Auth/OnBoardingScreen.dart';
import 'package:book_store/Auth/SignUp_Screen/SignUP_Screen.dart';
import 'package:book_store/home%20screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF1EEE9),
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF3E463B),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF1EEE9),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.to(Onboardingscreen());
          },
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFF3E463B),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.07,
                ),
                // Email TextFormField
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xFF8D8D8D)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade600),
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                      color: Color(0xFF8D8D8D),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Password TextFormField
                TextFormField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Color(0xFF8D8D8D)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade600),
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.lock,
                      color: Color(0xFF8D8D8D),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xFF8D8D8D),
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Remember me and Forget Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: _toggleRememberMe,
                        ),
                        Text("Remember me"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget password?",
                        style: TextStyle(
                          color: Color(0xFF8D8D8D),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),

                // Login Button
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.offAll(const Home());
                    },
                    child: CreateAccContainer(
                      fontColor: Colors.white,
                      height: height * 0.06,
                      width: width * 0.87,
                      text: "Login",
                      color: Color(0xFF3E463B),
                      isBorder: false,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Social Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Bootstrap.google,
                      color: Colors.red,
                      size: 40,
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(SignupScreen());
                      },
                      child: Text(
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
