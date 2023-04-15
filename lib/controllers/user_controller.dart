import 'dart:developer';

import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/services/firebase_auth_service.dart';
import 'package:food_delivery_app/services/user_service.dart';
import 'package:food_delivery_app/storage/user_prefs.dart';
import 'package:food_delivery_app/utils/logger.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  final _logger = Logger("UserController");
  final _loading = false.obs;
  bool get isLoading => _loading.value;

  final  _user = Rxn<User>();
  User? get user => _user.value;
  bool get isSignedIn => user!=null;

  List<String> get getFavItemIds => user?.favItems??[];

  final _loadingSigleItem = {}.obs;
  bool loadingSingleItem(String itemId){
    return _loadingSigleItem[itemId]==true;
  }
  
  // final _testUser = User(
  //   id: "1",
  //   fullName: "Deepak Chaurasiya",
  //   email: "deepak@gmail.com",
  //   phone: "9876543210"
  // );

  @override
  void onInit() {
    super.onInit();
    
    // fetchProfile();
    
  }

  Future fetchProfile({ String? userId ,bool enableLoading = false})async{
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
    if(enableLoading){
      _loading(false);
    }
  }

  Future addItemToFav(String itemId)async{
    if(!isSignedIn){
      _logger.message("addItemToFav", "Not Signed In!");
      return false;
    }
    _loadingSigleItem[itemId] = true;
    final res = await UserService.addItemToFav(
      userId: user?.id??'',
      itemId: itemId
    );
    if(res){
      _logger.message("addItemToFav", "Item added to fav : $itemId");
      _user.update((val) {
        val?.favItems.add(itemId);
        _user(val);
      });
    }
    _loadingSigleItem[itemId] = false;
  }

  Future removeItemFromFav(String itemId)async{
    if(!isSignedIn){
      _logger.message("removeItemFromFav", "Not Signed In!");
      return false;
    }
    _loadingSigleItem[itemId] = true;
    final res = await UserService.removeItemFromFav(
      userId: user?.id??'',
      itemId: itemId
    );
    if(res){
      _logger.message("removeItemFromFav", "Item removed from fav : $itemId");
      _user.update((val) {
        val?.favItems.remove(itemId);
        _user(val);
      });
    }
    _loadingSigleItem[itemId] = false;
  }


  Future<bool> updateProfile(Map<String,dynamic> data)async{
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