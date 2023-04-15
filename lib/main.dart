import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/splash_screen.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main()async{
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e,s) {
    log("ERROR : Initialization Error , $e",stackTrace: s);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      home: const SplashScreen()
    );
  }
}
