
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';
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
                  // AppNavigator.push(context, FavoritePetsScreen());
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
                }, 
                icon: CupertinoIcons.bag,
                title: "Orders",
              ),
              const Divider(thickness: 2,),
              // if(_userController.isSignedIn)
              //  _DrawerTile(
              //     onTap: ()async{
              //       // _userController.logOut();
              //       // AppNavigator.pushAndRemoveUntil(context, const SplashScreen());
              //     }, 
              //     icon: Icons.logout,
              //     title: "Sign Out",
              //   ),
             
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


  Widget drawerHeader(User? user){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Profile Pic
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CachedImageContainer(
              imgUrl: user?.profilePic??Constants.defaultPic,
              height: 80,
              width: 80,
              borderRadius: BorderRadius.circular(100),
            )
          ),
          const SizedBox(height: 12,),
          Text(
            user!=null
            ? "${user.fullName}"
            : "Sign In",
            style: const TextStyle(
              fontSize: 20
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8,),
          Text(
            user?.mobile??'',
            style: const TextStyle(
              fontSize: 14
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            user?.email??'',
            style: const TextStyle(
              fontSize: 14
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        
        ],
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
      padding: const EdgeInsets.all(8),
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