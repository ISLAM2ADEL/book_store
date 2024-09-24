import 'package:book_store/book%20space%20cubit/form%20cubit/text_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool isPhone;
  final bool isEmail;
  final bool isPassword;

  const CustomTextForm({
    super.key,
    this.controller,
    required this.hintText,
    required this.icon,
    this.validator,
    this.isPassword = false,
    this.isPhone = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TextFormCubit>();
    return BlocBuilder<TextFormCubit, TextFormState>(
      builder: (context, state) {
        bool obscureText = cubit.getObscureText();
        return TextFormField(
          obscureText: isPassword && obscureText ? true : false,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
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
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF8D8D8D),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFF8D8D8D),
                    ),
                    onPressed: () {
                      cubit.changeObscureText();
                    },
                  )
                : null,
          ),
          validator: validator,
          keyboardType: isPhone
              ? TextInputType.phone
              : isEmail
                  ? TextInputType.emailAddress
                  : null,
        );
      },
    );
  }
}
