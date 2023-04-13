
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/auth/sign_up_screen.dart';
import 'package:food_delivery_app/widgets/app_icon_widget.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _loading=ValueNotifier(true);

  @override
  void initState() {
    init();
    super.initState();
  }

  void init(){
    _loading.value=true;
    Future.delayed(Duration(milliseconds: 2000),(){
      _loading.value=false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder<bool>(
      valueListenable: _loading,
      builder: (context, isLoading, child) {
        if(isLoading){
          return _splash;
        }
        return SignUpScreen();
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