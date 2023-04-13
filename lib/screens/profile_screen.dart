
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:food_delivery_app/widgets/not_signed_in.dart';
import 'package:food_delivery_app/widgets/user_profile_widget.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin<ProfileScreen>{

  final _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Obx((){
          if(_userController.isLoading){
            return CircularProgressIndicator();
          }
          if(!_userController.isSignedIn){
            return NotSignedIn();
          }
          final user = _userController.user!;
          return Column(
            children: [
              UserProfileWidget(
                user: user,
              ),

            ],
          );
        }),
      )
     
    );
  }


  

  @override
  bool get wantKeepAlive=>true;
}
