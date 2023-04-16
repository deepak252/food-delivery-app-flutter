
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/item/cart_item_tile.dart';
import 'package:food_delivery_app/widgets/item/order_item_tile.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({ Key? key }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>{
  
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
      enableLoading: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order",
        ),
        titleSpacing: 0,
      ),
      body: Obx((){
        if(_itemController.isLoadingCartItems){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(_itemController.cartItems.length==0){
          return NoResultWidget(
            title: "No Items",
            onRefresh: ()async{
            },
          );
        }
        
        return RefreshIndicator(
          onRefresh: fetchCartItems,
          child : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6),
            itemCount: _itemController.cartItems.length+1,
            itemBuilder: (BuildContext context, int index){
              if(index==_itemController.cartItems.length){
                return billingDetails(
                  _itemController.cartTotalPrice
                );
              }
              if(_itemController.cartItems[index].item==null){
                return SizedBox();
              }
              return OrderItemTile(
                item : _itemController.cartItems[index].item!,
              );
            },
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx((){
        if(_itemController.cartItems.isEmpty){
          return SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomElevatedButton(
            onPressed: (){

            },
            borderRadius: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 12,),
                Flexible(
                  child: Text(
                    "Order Now",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                // SizedBox(width: 12,),
                // Text(
                //   "₹ ${_itemController.cartTotalPrice}",
                //   style: TextStyle(fontSize: 16),
                // ),
                // SizedBox(width: 12,),
              ],
            ),
          ),
        );
      })
    );
  }

  Widget billingDetails(double orderAmount){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Themes.colorPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        // boxShadow: [ 
        //   BoxShadow(
        //   color: Colors.black.withAlpha(20), 
        //   spreadRadius: 1, 
        //   blurRadius: 5,
        // ),],
        border:  Border.all(
          color: Themes.colorPrimary
        )
      ),
      child: Column(
        children: [
          fieldValue(
            field: "Order Amount", 
            value: "₹ $orderAmount"
          ),
          fieldValue(
            field: "GST", 
            value: "₹ ${orderAmount*0.18}"
          ),
          fieldValue(
            field: "Discount", 
            value: "₹ 0"
          ),
          Divider(),
          fieldValue(
            field: "Total", 
            value: "₹ ${orderAmount*1.18}",
            bold: true
          ),
        ],
      ),
    );
  }

  Widget fieldValue({
    required String field,
    required String value,
    bool bold=false
  }){
    return Row(
      children: [
        Expanded(
          child: Text(
            field,
            style: TextStyle(
              fontWeight: bold? FontWeight.bold : null
            ),
          ),
        ),
        SizedBox(width: 8,),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold? FontWeight.bold : null
          ),
        ),
      ],
    );
  }

}
