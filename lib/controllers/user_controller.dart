import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/cart_item.dart';
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

  final hindiDesc = false.obs;
  bool get isHindiDesc => hindiDesc.value;

  final  _user = Rxn<User>();
  User? get user => _user.value;
  bool get isSignedIn => user!=null;

  Address? get address => user?.address;

  List<String> get getFavItemIds => user?.favItems??[];
  List<CartItem> get getCartItems => user?.cartItems??[];

  // final _itemController = Get.find<ItemController>();
  final _itemController = Get.put(ItemController());

  bool isItemInCart(String itemId){
    return getCartItems.indexWhere((e) => e.itemId==itemId)!=-1;
  }

  int getCartItemQty(String itemId){
    return getCartItems.firstWhereOrNull(
      (e) => e.itemId==itemId)?.quantity??1;
  }

  final _loadingSigleItem = {}.obs;
  bool loadingSingleItem(String itemId){
    return _loadingSigleItem[itemId]==true;
  }
  
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

  Future<bool?> updateProfile({ required User updatedUser ,bool enableLoading = false})async{
    if(enableLoading){
      _loading(true);
    }
    bool? res = await UserService.updateUser(updatedUser);
    if(res==true){
      _logger.message("updateProfile", "User Profile Updated");
      await fetchProfile();
      return true;
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

  Future addItemToCart(String itemId)async{
    if(!isSignedIn){
      _logger.message("addItemToCart", "Not Signed In!");
      return false;
    }
    if(isItemInCart(itemId)){
      _logger.message("addItemToCart", "Item already in cart!");
      return false;
    }
    _loadingSigleItem[itemId] = true;
    final cartItem = CartItem(itemId: itemId);
    final newList = [...getCartItems,cartItem];
    final res = await UserService.updateCart(
      userId: user?.id??'',
      cartItems: newList
    );
    if(res){
      _logger.message("addItemToCart", "Item added to cart : $itemId");
      _itemController.fetchCartItems(cart: newList, enableLoading: false);
      _user.update((val) {
        // val?.cartItems.add(cartItem);
        val?.cartItems = newList;
        _user(val);
      });
    }
    _loadingSigleItem[itemId] = false;
  }

  Future removeItemFromCart(String itemId)async{
    if(!isSignedIn){
      _logger.message("removeItemFromCart", "Not Signed In!");
      return false;
    }
    if(!isItemInCart(itemId)){
      _logger.message("removeItemFromCart", "Item not in cart!");
      return false;
    }
    _loadingSigleItem[itemId] = true;
    final newList = getCartItems.where((e) => e.itemId!=itemId).toList();
    final res = await UserService.updateCart(
      userId: user?.id??'',
      cartItems: newList
    );
    if(res){
      _logger.message("removeItemFromCart", "Item removed from cart : $itemId");
      _itemController.fetchCartItems(cart: newList, enableLoading: false);
      _user.update((val) {
        val?.cartItems = newList;
        _user(val);
      });
    }
    _loadingSigleItem[itemId] = false;
  }

  Future<bool> removeCartAllITems()async{
    if(!isSignedIn){
      _logger.message("removeCartAllITems", "Not Signed In!");
      return false;
    }
    final res = await UserService.updateCart(
      userId: user?.id??'',
      cartItems: []
    );
    if(res){
      _logger.message("removeCartAllITems", "Items removed from cart");
      _itemController.fetchCartItems(cart: [], enableLoading: false);
      _user.update((val) {
        val?.cartItems = [];
        _user(val);
      });
      return true;
    }
    return false;
  }

  Future updateCartItemQty(String itemId, int qty)async{
    if(!isSignedIn){
      _logger.message("updateCartItemQty", "Not Signed In!");
      return false;
    }
    if(qty<1){
      return false;
    }
    if(!isItemInCart(itemId)){
      _logger.message("updateCartItemQty", "Item not in cart!");
      return false;
    }
    _loadingSigleItem[itemId] = true;
    List<CartItem> newList = [];
    for(int i=0;i<getCartItems.length;i++){
      newList.add(getCartItems[i]);
      if(getCartItems[i].itemId==itemId){
        newList[i].quantity = qty;
      }
    }
    // getCartItems.where((e) => e.itemId!=itemId).toList();
    final res = await UserService.updateCart(
      userId: user?.id??'',
      cartItems: newList
    );
    if(res){
      _logger.message("updateCartItemQty", "Cart qty updated: $itemId");
      _itemController.fetchCartItems(cart: newList, enableLoading: false);
      _user.update((val) {
        val?.cartItems = newList;
        _user(val);
      });
    }
    _loadingSigleItem[itemId] = false;
  }


  Future logOut()async{
    await FirebaseAuthService.signOut();
    _user(null);
    await UserPrefs.clearData();
    await Get.delete<BottomNavController>();
    await Get.delete<UserController>();
    await Get.delete<ItemController>();
  }

}