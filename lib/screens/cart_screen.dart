
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/screens/checkout/checkout_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/item/cart_item_tile.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen>{
  
  final _itemController = Get.find<ItemController>();
  final _userController = Get.find<UserController>();
  
  @override
  void initState() {
    fetchCartItems();
    super.initState();
  }

  Future fetchCartItems()async{
    await _itemController.fetchCartItems(
      cart : _userController.getCartItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Obx((){
        if(_itemController.isLoadingCartItems){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(_itemController.cartItems.length==0){
          return NoResultWidget(
            title: "Cart is empty!",
            onRefresh: ()async{
            },
          );
        }
        
        return RefreshIndicator(
          onRefresh: fetchCartItems,
          child : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6),
            itemCount: _itemController.cartItems.length,
            itemBuilder: (BuildContext context, int index){
              if(_itemController.cartItems[index].item==null){
                return SizedBox();
              }
              return CartItemTile(
                item : _itemController.cartItems[index].item!,
              );
            },
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx((){
        if(_itemController.cartItems.isEmpty){
          return SizedBox();
        }
        return CustomElevatedButton(
          onPressed: (){
            AppNavigator.push(context, CheckoutScreen());
          },
          width : 0,
          borderRadius: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 12,),
              Flexible(
                child: Text(
                  "Checkout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(width: 12,),
              Text(
                "₹ ${_itemController.orderAmount}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 12,),
            ],
          ),
        );
      })
    );
    
  }

  @override
  bool get wantKeepAlive=>true;
}
