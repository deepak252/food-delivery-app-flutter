import 'dart:developer';

import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food_category.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/services/item_service.dart';
import 'package:food_delivery_app/utils/logger.dart';
import 'package:food_delivery_app/utils/num_utils.dart';
import 'package:get/get.dart';

/// For the STATE of food items.
class ItemController extends GetxController {
  final _logger = Logger("ItemController");
  
  final _selectedCategory = Rxn<FoodCategory>();
  FoodCategory? get selectedCategory => _selectedCategory.value;
  set setCategory(FoodCategory? category) => _selectedCategory(category);

  final _loadingItems = false.obs;
  bool get isLoadingItems => _loadingItems.value;
  final _items = Rxn<List<Item>>();
  List<Item> get items => _items.value??[];
  Item? itemById(String itemId){
    return items.firstWhereOrNull((e) => e.id==itemId);
  }

  final _loadingFavItems = false.obs;
  bool get isLoadingFavItems => _loadingFavItems.value;
  final _favItems = Rxn<List<Item>>();
  List<Item> get favItems => _favItems.value??[];

  final _loadingCartItems = false.obs;
  bool get isLoadingCartItems => _loadingCartItems.value;
  final _cartItems = Rxn<List<CartItem>>();
  List<CartItem> get cartItems => _cartItems.value??[];
  double get orderAmount{
    double amount = cartItems.fold(
      0, (prev, e) => prev+ (e.item?.price??0)*(e.quantity??1)
    );
    return NumUtils.parseDouble(amount, precision: 2);
  }
  double get gstAmount => NumUtils.parseDouble(orderAmount*0.18, precision: 2);
  double get totalAmount => NumUtils.parseDouble(orderAmount*1.18,precision: 2);

  Item? getItemById(String itemId){
    int i;
    i = items.indexWhere((e) => e.id == itemId);
    if (i != -1) {
      return items[i];
    }
    i = favItems.indexWhere((e) => e.id == itemId);
    if (i != -1) {
      return favItems[i];
    }
    i = cartItems.indexWhere((e) => e.item?.id == itemId);
    if (i != -1) {
      return cartItems[i].item;
    }
    return null;
  }

  final _loadingSigleItem = {}.obs;
  bool loadingSingleItem(String itemId){
    return _loadingSigleItem[itemId]==true;
  }

  @override
  void onInit() {
    // fetchFoodItems(); //Fetch products on initialize
    super.onInit();
  }

  Future fetchItems({bool enableLoading = false}) async {
    if(enableLoading){
      _loadingItems(true);
    }
    final items = await ItemService.getItems();
    _items(items);

    if(enableLoading){
      _loadingItems(false);
    }
  }

  Future addItemReview({required String itemId, required ItemReview review})async{
    _loadingSigleItem[itemId] = true;
    final res = await ItemService.addItemReview(
      itemId: itemId,
      review: review
    );
    if(res){
      _logger.message("addItemReview", "Review added : $itemId");
      await fetchSpecificItem(itemId);
    }
    _loadingSigleItem[itemId] = false;
    return res;
  }

  Future fetchSpecificItem( String itemId,{ bool enableLoading = false}) async {
    if(enableLoading){
      _loadingSigleItem[itemId] = true;
    }
    final item = await ItemService.getSpecificItem(itemId);
    if(item!=null){
      _items.update((oldList) {
        if (oldList != null) {
          int i = oldList.indexWhere((e) => e.id == item.id);
          if (i != -1) {
            oldList[i]=item;
            _items(oldList);
          }
        }
      });

      _favItems.update((oldList) {
        if (oldList != null) {
          int i = oldList.indexWhere((e) => e.id == item.id);
          if (i != -1) {
            oldList[i]=item;
            _favItems(oldList);
          }
        }
      });

      _cartItems.update((oldList) {
        if (oldList != null) {
          int i = oldList.indexWhere((e) => e.item?.id == item.id);
          if (i != -1) {
            oldList[i].item=item;
            _cartItems(oldList);
            // log("Cart Item updated");
          }
        }
      });
    }

    if(enableLoading){
     _loadingSigleItem[itemId] = false;
    }
  }

  Future fetchFavItems({required List<String> favItemIds, bool enableLoading = true}) async {
    if(enableLoading){
      _loadingFavItems(true);
    }
    final res = await ItemService.getSpecificItems(favItemIds);
    _favItems(res);
    if(enableLoading){
      _loadingFavItems(false);
    }
  }

  Future fetchCartItems({required List<CartItem> cart, bool enableLoading = true}) async {
    if(enableLoading){
      _loadingCartItems(true);
    }
    final res = await ItemService.getSpecificItems(
      cart.map((e) => e.itemId).toList()
    );
    if(res!=null){
      for(int i=0;i<cart.length;i++){
        final item  = res.firstWhereOrNull((e) => e.id==cart[i].itemId);
        cart[i].item=item;
      }
    }
    _cartItems(cart);
    if(enableLoading){
      _loadingCartItems(false);
    }
  }
  
}