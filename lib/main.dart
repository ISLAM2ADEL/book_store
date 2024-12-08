import 'package:book_store/book%20space%20cubit/admin%20cubit/bottom%20bar/admin_bar_cubit.dart';
import 'package:book_store/book%20space%20cubit/admin%20cubit/edit%20book/edit_cubit.dart';
import 'package:book_store/book%20space%20cubit/awesome%20cubit/awesome_cubit.dart';
import 'package:book_store/book%20space%20cubit/bottom%20cubit/bottom_cubit.dart';
import 'package:book_store/book%20space%20cubit/description%20Cubit/description_cubit.dart';
import 'package:book_store/book%20space%20cubit/form%20cubit/text_form_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/best%20seller%20cubit/best_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/category%20cubit/category_cubit.dart';
import 'package:book_store/book%20space%20cubit/home%20cubit/home_cubit.dart';
import 'package:book_store/book%20space%20cubit/library%20cubit/library_cubit.dart';
import 'package:book_store/screens/Auth/forget_screen/Cubit/forget_cubit.dart';
import 'package:book_store/screens/Auth/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'book space cubit/admin cubit/add book/image_cubit.dart';
import 'book space cubit/admin cubit/dashboard cubit/dash_cubit.dart';
import 'book space cubit/authors cubit/author_cubit.dart';
import 'book space cubit/cubit/settings_cubit.dart';
import 'book space cubit/favourite cubit/favourite_cubit.dart';
import 'book space cubit/recent cubit/recent_cubit.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
        BlocProvider(
          create: (context) => BestCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider(
          create: (context) => EditCubit(),
        ),
        BlocProvider(
          create: (context) => AuthorCubit(),
        ),
        BlocProvider(
          create: (context) => DescriptionCubit(),
        ),
        BlocProvider(
          create: (context) => DashCubit(),
        ),
        BlocProvider(
          create: (context) => LibraryCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => RecentCubit(),
        ),
      ],
      child: const GetMaterialApp(
          debugShowCheckedModeBanner: false, home: Splashscreen()),
    );
  }
}
