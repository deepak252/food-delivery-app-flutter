
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:food_delivery_app/screens/auth/sign_up_screen.dart';
import 'package:food_delivery_app/screens/dashboard.dart';
import 'package:food_delivery_app/widgets/app_icon_widget.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _loading=ValueNotifier(true);
  final _userController = Get.put(UserController());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init()async{
    _loading.value=true;
    await _userController.fetchProfile(
      enableLoading: true
    );
    _loading.value=false;
    // Future.delayed(Duration(milliseconds: 1000),(){
    //   _loading.value=false;
    // });
  }

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