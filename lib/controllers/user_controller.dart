import 'dart:developer';

import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/services/firebase_auth_service.dart';
import 'package:food_delivery_app/services/user_service.dart';
import 'package:food_delivery_app/storage/user_prefs.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final _loading = false.obs;
  bool get isLoading => _loading.value;

  final  _user = Rxn<User>();
  User? get user => _user.value;
  bool get isSignedIn => user!=null;

  final _loadingNotifications = false.obs;
  bool get loadingNotifications => _loadingNotifications.value;
  
  // final _testUser = User(
  //   id: "1",
  //   fullName: "Deepak Chaurasiya",
  //   email: "deepak@gmail.com",
  //   phone: "9876543210"
  // );

  @override
  void onInit() {
    super.onInit();
    
    fetchProfile();
    
  }

  Future<bool?> fetchProfile({ String? userId ,bool enableLoading = false})async{
    if(enableLoading){
      _loading(true);
    }
    if(userId==null){
      userId = user?.id;
    }
    if(userId==null){
      _user(null);
    }else{
      final _usr = await UserService.getUser(userId);
      _user(_usr);
    }

    // await Future.delayed(Duration(milliseconds: 2000));
    // _user(_testUser);
    if(enableLoading){
      _loading(false);
    }
  }


  Future<bool> updateProfile(Map<String,dynamic> data)async{
    
    // log("${data}");
    // final user = await UserService.updateProfile(
    //   token: _token!,
    //   data: data
    // );
    if(user!=null){
      _user(user);
      return true;
    }
    return false;
  }


  Future logOut()async{
    await FirebaseAuthService.signOut();
    _user(null);
    await UserPrefs.clearData();
    await Get.delete<BottomNavController>();
    await Get.delete<UserController>();
  }

}