
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:food_delivery_app/screens/dashboard.dart';
import 'package:food_delivery_app/services/firebase_auth_service.dart';
import 'package:food_delivery_app/widgets/app_icon_widget.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _loading=ValueNotifier(false);
  final _userController = Get.put(UserController());

  @override
  void initState() {
    authStream();
    super.initState();
  }

  authStream()async{
    _loading.value=true;
    FirebaseAuthService.authStateChanges.listen((user)async{
      log("**** AUTH STATE CHANGED ****** : ${user}");
      if(user?.uid!=null){
        await Future.delayed(Duration(milliseconds: 10));
        _loading.value=true;
        await _userController.fetchProfile(
          userId: user?.uid
        );
        await Future.delayed(Duration(milliseconds: 1500));
        _loading.value=false;
      }
    });
    await Future.delayed(Duration(milliseconds: 20));
    _loading.value=false;
  }

  // void init()async{
  //   _loading.value=true;
  //   await _userController.fetchProfile(
  //     enableLoading: true
  //   );
  //   _loading.value=false;
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loading,
      builder: (context, isLoading, child) {
        if(isLoading){
          return _splash;
        }
        if(_userController.isSignedIn){
          return Dashboard();
        }
        return SignInScreen();
      }
    );
  }

  Widget get _splash =>const  Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: AppIconWidget()
    ),
  );
}