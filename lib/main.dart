import 'package:fideos_web/presentation/menus/add_menu.dart';
import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/model/font.dart';
import 'package:fideos_web/presentation/auth/login.dart';
import 'package:fideos_web/presentation/auth/more_details.dart';
import 'package:fideos_web/presentation/auth/registration.dart';
import 'package:fideos_web/presentation/home_screen.dart';
import 'package:fideos_web/presentation/menus/menu.dart';
import 'package:fideos_web/presentation/profile/add_image.dart';
import 'package:fideos_web/presentation/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/foods/add_food.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* firebase initialization for flutter web *//
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyAe5pP1L9TaviPOO3HzEsCnTxd_Aj0Tf2M",
  //     projectId: "fideos-2b1db",
  //     storageBucket: "fideos-2b1db.appspot.com",
  //     messagingSenderId: "294197064538",
  //     appId: "1:294197064538:web:02ba3fe75ece3b360ab963",
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fideos Admin Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: Fonts.regular,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: AppColor.primary)),
      home: HomeScreen(),
    );
  }
}
