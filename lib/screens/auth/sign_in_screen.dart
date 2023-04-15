import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/screens/auth/sign_up_screen.dart';
import 'package:food_delivery_app/services/firebase_auth_service.dart';
import 'package:food_delivery_app/splash_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/keyboard_utils.dart';
import 'package:food_delivery_app/utils/text_validator.dart';
import 'package:food_delivery_app/widgets/app_icon_widget.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_loading_indicator.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:food_delivery_app/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final _passwordVisibilityNotifier = ValueNotifier<bool>(false);


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>unfocus(context),
      child: Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: AppBar(
          title: const Text("Sign In"),
        ),
        body: SingleChildScrollView(
          physics : const BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16
              ),
              child: Column(
                children : [
                  const SizedBox(height: 12,),
                  const AppIconWidget(),
                  const SizedBox(height: 36,),
                  CustomTextField(
                    controller: _emailController,
                    hintText: " Email",
                    validator: TextValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18,),
                  ValueListenableBuilder<bool>(
                    valueListenable: _passwordVisibilityNotifier,
                    builder: (context,_passwordVisible, child) {
                      return CustomTextField(
                        controller: _passwordController,
                        hintText: " Password",
                        obscureText: !_passwordVisible,
                        suffixIcon: passwordVisibilityIcon(_passwordVisibilityNotifier),
                        validator: TextValidator.validatePassword,
                      );
                    }
                  ),
                  const SizedBox(height: 12,),
                  Align(
                    alignment : Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        // AppNavigator.push(context, const ResetPasswordScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Themes.colorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36,),
                  CustomElevatedButton(
                    onPressed: ()async{
                      if(!_formkey.currentState!.validate()){
                        return;
                      }
                      try{
                        customLoadingIndicator(context: context,canPop: false);
                        final user = await FirebaseAuthService.signIn(
                          email: _emailController.text.trim(), 
                          password: _passwordController.text.trim()
                        );
                        Navigator.pop(context); //Dismiss loading indicator
                        AppNavigator.pushAndRemoveUntil(context, const SplashScreen());
                        
                      }catch(e,s){
                        log("ERROR ",error: e, stackTrace: s);
                        Navigator.pop(context); //Dismiss loading indicator
                        CustomSnackbar.error(error: e);
                      }
                      
                    },
                    text: "Sign In",
                  ),
                  const SizedBox(height: 18,),
                  const Text(
                    "Don't have an account? ",
                  ),
                  GestureDetector(
                    onTap: (){
                      unfocus(context);
                      AppNavigator.push(context, const SignUpScreen());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Themes.colorPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),
                  
                ]
              ),
            ),
          ),
        ),
      ),
    );

    
  }

  IconButton  passwordVisibilityIcon(ValueNotifier<bool> _visibilityNotifier){
    return IconButton(
      splashRadius: 1,
      icon: Icon(
        // Based on passwordVisible state choose the icon
        _visibilityNotifier.value ? Icons.visibility : Icons.visibility_off,
        color: _visibilityNotifier.value ? Themes.colorPrimary : Themes.black300,
        size: 23,
      ),
      onPressed: () {
        _visibilityNotifier.value = !_visibilityNotifier.value;
      },
      padding: const EdgeInsets.only(right: 8),
    );
  }
}