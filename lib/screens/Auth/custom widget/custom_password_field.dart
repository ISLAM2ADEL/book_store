import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  CustomPasswordFieldState createState() => CustomPasswordFieldState();
}

class CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xFF8D8D8D)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red.shade300, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red.shade600, width: 2),
        ),
        prefixIcon: const Icon(
          CupertinoIcons.lock,
          color: Color(0xFF8D8D8D),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF8D8D8D),
          ),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
