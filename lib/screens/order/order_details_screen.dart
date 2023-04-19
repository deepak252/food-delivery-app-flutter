
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


class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  OrderDetailsScreen({ Key? key, required this.order }) : super(key: key);

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
        ),
        titleSpacing: 0,
      ),
      body: Padding(
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
            SizedBox(height: 6,),
            Row(
              children: [
                const Icon(Icons.location_pin,size: 20,),
                SizedBox(width: 4,),
                Expanded(
                  child: Text(
                    "${_userController.address?.completeAddress}",
                    style: const TextStyle(
                      fontSize: 14, 
                      color: Themes.colorPrimary
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Text(
              "Billing",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            billingDetails(
              order.orderAmount??0,
              order.gstAmount??0,
              order.totalAmount??0,
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
                itemCount: order.items.length,
                itemBuilder: (BuildContext context, int index){
                  if(order.items[index].item==null){
                    return SizedBox();
                  }
                  return OrderItemTile(
                    item : order.items[index].item!
                  );
                },
              ),
            ),
            SizedBox(height: 65,),
          ],
        ),
      ),
      
      
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
