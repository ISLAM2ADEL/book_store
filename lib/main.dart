import 'package:book_store/Auth/forget_screen/Cubit/forget_cubit.dart';
import 'package:book_store/Auth/splash_screen.dart';
import 'package:book_store/admin%20screens/add%20book/add_book.dart';
import 'package:book_store/book%20space%20cubit/admin%20cubit/bottom%20bar/admin_bar_cubit.dart';
import 'package:book_store/book%20space%20cubit/awesome%20cubit/awesome_cubit.dart';
import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/book%20space%20cubit/form%20cubit/text_form_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:book_store/home%20screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'admin screens/admin const.dart';
import 'book space cubit/admin cubit/add book/image_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '=================================================User is currently signed out!');
      } else {
        print(
            '=================================================User is signed in!');
      }
    });
    super.initState();
  }

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
        BlocProvider(
          create: (context) => AwesomeCubit(),
        ),
        BlocProvider(
          create: (context) => AdminBarCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser == null ||
                !FirebaseAuth.instance.currentUser!.emailVerified)
            ? const Splashscreen()
            : FirebaseAuth.instance.currentUser?.email == adminEmail
                ? AddBook()
                : const Home(),
      ),
    );
  }
}
