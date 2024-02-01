import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/widgets/app_icon_widget.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_outlined_button.dart';
import 'package:get/get.dart';

class PostCheckoutScreen extends StatelessWidget {
  PostCheckoutScreen({super.key});
  final _bottomNavController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.colorPrimary.withOpacity(0.9),
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical:8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            AppIconWidget(),
            SizedBox(height: 50,),
            Text(
              "Order Created Successfully",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            // CustomElevatedButton(
            //   onPressed: ()async{
            //     Navigator.pop(context);
            //     _bottomNavController.changeRoute(index: 0);
            //   },
            //   borderRadius: 100,
            //   text: "Back To Home"
            // ),
            SizedBox(height: 20,),
            CustomOutlinedButton(
              onPressed: ()async{
                Navigator.pop(context);
                _bottomNavController.changeRoute(index: 0);
              },
              borderRadius: 100,
              text: "Back To Home",
              borderColor: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}