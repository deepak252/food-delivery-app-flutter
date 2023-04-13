import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/profile_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/app_drawer.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _bottomNavController = Get.put(BottomNavController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(_bottomNavController.currentIndex!=0){
          _bottomNavController.changeRoute(index: 0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity,55),
          child: Obx((){
            int index=_bottomNavController.currentIndex;
            return AppBar(
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.bars,
                  size: 30,
                ),
                // icon: Image.asset(
                //   ImagePath.menu,
                //   height: 28,
                //   width: 28,
                // ),
                onPressed: (){
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: Text(
                index==0
                ? "Foodie"
                : index==1
                  ? "Cart"
                  : "Profile",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),
              ),
              actions: [
                // if(index==0)
                //   CustomIconButton(
                //     onPressed: (){
                //       // AppNavigator.push(context, NotificationScreen());
                //     },
                //     icon: Icons.notifications_on_rounded,
                //   )
               
              ]
            );}
          ),
        ),
        drawer: AppDrawer(),

        body: PageView(
          controller: _bottomNavController.pageController,
          children: [
            HomeScreen(),
            CartScreen(),
            ProfileScreen(),
          ],
          onPageChanged: (index) {
            _bottomNavController.setIndex=index;
          },
        ),

        bottomNavigationBar: Obx((){
          return Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 16,
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                // backgroundColor: Themes.colorPrimary,
                currentIndex: _bottomNavController.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart, size: 22,),
                    label: "Cart"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label:"Profile"
                  ),
                ],
                onTap: (int index) {
                  _bottomNavController.changeRoute(index: index);
                },
              ),
            ),
          );
        })
      ),
    );
  }
}