import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/keyboard_utils.dart';
import 'package:food_delivery_app/utils/text_validator.dart';
import 'package:food_delivery_app/widgets/app_icon_widget.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cfPasswordController = TextEditingController();

  final _passwordVisibilityNotifier = ValueNotifier<bool>(false);
  final _cfPasswordVisibilityNotifier = ValueNotifier<bool>(false);  //for confirm password

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _cfPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>unfocus(context),
      child: Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: AppBar(
          title: const Text("Sign Up"),
          titleSpacing: 0,
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
                    controller: _nameController,
                    hintText: " Name",
                    validator: TextValidator.validateName,
                  ),
                  const SizedBox(height: 18,),
                  CustomTextField(
                    controller: _emailController,
                    hintText: " Email",
                    validator: TextValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18,),
                  CustomTextField(
                    controller: _phoneController,
                    hintText: " Phone",
                    validator: TextValidator.validatePhoneNumber,
                    keyboardType: TextInputType.phone,
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
                  const SizedBox(height: 18,),
                  ValueListenableBuilder<bool>(
                    valueListenable: _cfPasswordVisibilityNotifier,
                    builder: (context,_cfPasswordVisible, child) {
                      return CustomTextField(
                        controller: _cfPasswordController,
                        hintText: " Confirm Password",
                        obscureText: !_cfPasswordVisible,
                        suffixIcon: passwordVisibilityIcon(_cfPasswordVisibilityNotifier),
                        validator: (confirmPassword)=> TextValidator.validateConfirmPassword(
                          confirmPassword, _passwordController.text
                        ),
                      );
                    }
                  ),
                  
                  const SizedBox(height: 36,),
                  CustomElevatedButton(
                    onPressed: ()async{
                      if(!_formkey.currentState!.validate()){
                        return;
                      }
                      // customLoadingIndicator(context: context,canPop: false);
                      
                    },
                    text: "Sign Up",
                  ),
                  const SizedBox(height: 18,),
                  const Text(
                    "Already have an account? ",
                  ),
                  GestureDetector(
                    onTap: (){
                      unfocus(context);
                      AppNavigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Sign In",
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