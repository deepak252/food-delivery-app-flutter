import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/auth/sign_in_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';

class NotSignedIn extends StatelessWidget {
  const NotSignedIn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child : Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomElevatedButton(
          onPressed: ()async{
            AppNavigator.push(context, const SignInScreen());
          },
          text: "Sign In",
        ),
      )
    );
  }
}