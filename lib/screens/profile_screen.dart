
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/screens/fav_items_screen.dart';
import 'package:food_delivery_app/screens/order/order_history_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
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
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            children: [
              UserProfileWidget(
                user: user,
              ),
              SizedBox(height: 20,),
              optionWidget(
                label: "My Orders",
                icon: CupertinoIcons.bag,
                onTap: (){
                  AppNavigator.push(context, OrderHistoryScreen());
                }
              ),
              Divider(),
              optionWidget(
                label: "My Favorites",
                icon: CupertinoIcons.heart,
                onTap: (){
                  AppNavigator.push(context, FavItemsScreen());
                }
              ),
              Divider(),

            ],
          );
        }),
      )
     
    );
  }


  Widget optionWidget({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
  }){
    return ListTile(
      onTap: onTap,
      tileColor: Colors.white,
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18
        ),
      ),
      leading: Icon(
        icon,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ),
    );
  }

  

  @override
  bool get wantKeepAlive=>true;
}
