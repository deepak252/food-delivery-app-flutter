
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/screens/checkout/post_checkout_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/location_utils.dart';
import 'package:food_delivery_app/widgets/address_bottom_sheet.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_loading_indicator.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:food_delivery_app/widgets/field_value_widget.dart';
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
  final _orderController = Get.put(OrderController());
  
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
          "Checkout",
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

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.location_pin,size: 20,),
                  SizedBox(width: 4,),
                  Expanded(
                    child: Text(
                      "${_userController.address?.completeAddress}",
                      style: const TextStyle(
                        fontSize: 14, 
                        // fontWeight: FontWeight.bold,
                        color: Themes.colorPrimary
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: ()async{
                      try{
                        customLoadingIndicator(context: context, canPop: false);
                        var location =await LocationUtils.getCurrentLocation();
                        Navigator.pop(context);
                        if(location==null){
                          throw "Couldn't find location";
                        }
                        log("Current Location : ${location.toJson()}");
                        await showAddressBottomSheet(
                          location
                        );
                      }catch(e,s){
                        log("Error",error: e,stackTrace: s);
                        CustomSnackbar.error(error: e);
                        await showAddressBottomSheet(
                          _userController.address
                        );
                      }
                      
                    }, 
                    icon: Icon(
                      _userController.address!=null
                      ? Icons.edit
                      : Icons.add,
                      size: 28,
                      color: Themes.colorPrimary,
                    )
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Text(
                "Billing",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              billingDetails(
                _itemController.orderAmount,
                _itemController.gstAmount,
                _itemController.totalAmount,
              ),
              SizedBox(height: 12,),
              Text(
                "Items",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _itemController.cartItems.length,
                  itemBuilder: (BuildContext context, int index){
                    if(_itemController.cartItems[index].item==null){
                      return SizedBox();
                    }
                    return OrderItemTile(
                      item : _itemController.cartItems[index].item!,
                    );
                  },
                ),
              ),
              SizedBox(height: 65,),
            ],
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
            onPressed: ()async{
              if(_userController.address==null){
                return CustomSnackbar.error(error: "Delivery address is required");
              }
              customLoadingIndicator(context: context, canPop: false);
              final order = Order(
                orderId: '', 
                userId: _userController.user?.id??'', 
                items: _itemController.cartItems.where((e) => e.item!=null).toList(), 
                orderAmount: _itemController.orderAmount, 
                gstAmount: _itemController.gstAmount, 
                totalAmount: _itemController.totalAmount, 
                deliveryAddress: _userController.address!,
                status: "Order Created",
                createdAt: firestore.Timestamp.now().toDate(),
                updatedAt: firestore.Timestamp.now().toDate(),
              );
              await _orderController.createOrder(
                order: order
              );
              bool cartDeleted = await _userController.removeCartAllITems();
              if(mounted){
                Navigator.pop(context);
              }
              if(cartDeleted){
                AppNavigator.pushReplacement(context, PostCheckoutScreen());
              }

            },
            borderRadius: 100,
            text: "Order Now"
          ),
        );
      })
    );
  }

  Widget billingDetails(
    double orderAmount,
    double gstAmount,
    double totalAmount
  ){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
      decoration: BoxDecoration(
        color: Themes.colorPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border:  Border.all(
          color: Themes.colorPrimary
        )
      ),
      child: Column(
        children: [
          FieldValueWidget(
            field: "Order Amount", 
            value: "₹ $orderAmount"
          ),
          FieldValueWidget(
            field: "GST", 
            value: "₹ $gstAmount"
          ),
          FieldValueWidget(
            field: "Discount", 
            value: "₹ 0"
          ),
          Divider(),
          FieldValueWidget(
            field: "Total", 
            value: "₹ $totalAmount",
            bold: true
          ),
        ],
      ),
    );
  }

}
