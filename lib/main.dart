import 'package:book_store/Auth/splash_screen.dart';
import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/book%20space%20cubit/form%20cubit/text_form_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TextFormCubit(),
        ),
        BlocProvider(
          create: (context) => BottomCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
