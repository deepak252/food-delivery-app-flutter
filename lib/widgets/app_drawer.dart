
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/screens/fav_items_screen.dart';
import 'package:food_delivery_app/screens/order/order_history_screen.dart';
import 'package:food_delivery_app/splash_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/user_profile_widget.dart';
import 'package:get/get.dart';


class AppDrawer extends StatelessWidget {
  AppDrawer({ Key? key, }) : super(key: key);
  final _bottomNavController = Get.put(BottomNavController());
  final _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Obx((){
          return ListView(
            children: [
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  // if(_userController.isSignedIn){
                  //   return;
                  // }
                  // AppNavigator.push(context, const SignInScreen());
                },  
                child: UserProfileWidget(
                  user: _userController.user,
                ),
              ),
              const SizedBox(height: 30,),
              const Divider(thickness: 2,),
              _DrawerTile(
                onTap: ()async{
                  Navigator.pop(context);
                  await Future.delayed(const Duration(milliseconds: 300));
                  _bottomNavController.changeRoute(index: 0);
                }, 
                icon: CupertinoIcons.home, 
                title: "Home",
                isSelected: _bottomNavController.currentIndex==0,
              ),
              _DrawerTile(
                onTap: (){
                  Navigator.pop(context);
                  AppNavigator.push(context, FavItemsScreen());
                }, 
                icon: Icons.favorite_border_outlined, 
                title: "Favorites",
              ),
              _DrawerTile(
                onTap: ()async{
                  Navigator.pop(context);
                  await Future.delayed(const Duration(milliseconds: 300));
                  _bottomNavController.changeRoute(index: 1);
                }, 
                icon: CupertinoIcons.cart,
                title: "Cart",
                isSelected: _bottomNavController.currentIndex==1,
              ),
              _DrawerTile(
                onTap: ()async{
                  Navigator.pop(context);
                  AppNavigator.push(context, OrderHistoryScreen());
                }, 
                icon: CupertinoIcons.bag,
                title: "Orders",
              ),
              const Divider(thickness: 2,),
              if(_userController.isSignedIn)
               _DrawerTile(
                  onTap: ()async{
                    // Navigator.pop(context);
                    await _userController.logOut();
                    AppNavigator.pushAndRemoveUntil(context, const SplashScreen());
                  }, 
                  icon: Icons.logout,
                  title: "Sign Out",
                ),
             
              _DrawerTile(
                onTap: (){
                  Navigator.pop(context);
                  // AppNavigator.push(context, const AboutUsScreen());
                }, 
                icon: Icons.info_outlined,
                title: "About Us",
              ),
              _DrawerTile(
                onTap: (){
                  Navigator.pop(context);
                  // AppNavigator.push(context, const HelpSupportScreen());
                }, 
                icon: Icons.support_agent_outlined,
                title: "Help & Support",
              ),
              
            ],
          );  
        })
        
      ),
    );
  }


  
}

class _DrawerTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final bool isSelected;
  const _DrawerTile({ 
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.isSelected = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color : isSelected==true? Colors.white : Themes.black600,
          ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: isSelected==true? Colors.white : Themes.black600,
                fontSize: 18,
              ),
            ),
          ),
          horizontalTitleGap: 4,
          selectedTileColor: Themes.colorPrimary.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          selected: isSelected,
          focusColor: Themes.colorPrimary.withOpacity(0.5)
        ),
      ),
    );
  }
}