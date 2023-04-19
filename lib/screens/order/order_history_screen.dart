
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/screens/order/order_details_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({ Key? key }) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  
  final _orderController = Get.put(OrderController());
  
  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  Future fetchOrders()async{
    await _orderController.fetchOrders(
      enableLoading: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
        ),
        titleSpacing: 0,
      ),
      body: Obx((){
        if(_orderController.isLoadingOrders){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(_orderController.orders.length==0){
          return NoResultWidget(
            title: "Not Orders!",
            onRefresh: ()async{
            },
          );
        }
        
        return RefreshIndicator(
          onRefresh: fetchOrders,
          child : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 6),
            itemCount: _orderController.orders.length+1,
            separatorBuilder: (context,index)=>Divider(
              height: 0,
              thickness: 1,
            ),
            itemBuilder: (BuildContext context, int index){
              if(index==_orderController.orders.length){
                return SizedBox();
              }
              return orderTile(
                _orderController.orders[index]
              );
            },
          ),
        );
      }),
    );
  }

  Widget orderTile(Order order){
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: (){
        AppNavigator.push(context, OrderDetailsScreen(order: order));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            Expanded(
              flex: 1,
              child : CachedImageContainer(
                imgUrl: order.items.length!=0 
                  ? order.items[0].item?.images[0]??Constants.appIconUrl
                  : Constants.appIconUrl,
                height: 100,
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${order.orderName}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4,),
                      
                      Text(
                        "₹ ${order.totalAmount}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${order.status}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${order.date}, ${order.time}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );

  }

}
