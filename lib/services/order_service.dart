import 'dart:developer';

import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/utils/logger.dart';

class OrderService{
  static final _logger = Logger("OrderService");
  static final _orderDB = FirestoreService("orders");

  static Future<bool> createOrder(Order order) async {
    try {
      String randomDocId = _orderDB.getRandomDocId();
      order.orderId = randomDocId;
      final orderJson = order.toJson();
      try {
        for(int i=0;i< order.items.length;i++){
          orderJson["items"]?[i]?["item"]?.remove("reviews");
          orderJson["items"]?[i]?["item"]?.remove("stock");
          log("${orderJson["items"][i]}");
        }
      } catch (e,s) {
        _logger.error("createOrder", error: e, stackTrace : s);
      }
      await _orderDB.setDoc(randomDocId,orderJson);    
      return true;   
    } catch (e,s) {
      _logger.error("createOrder", error: e, stackTrace : s);
    }
    return false;
  }

  static Future<List<Order>?> getOrders(String userId) async {
    try {
      final docs = await _orderDB.getDocsWithCondition(
        "userId", isEqualTo: userId
      );
      List<Order> orders = [];
      if(docs!=null){
        for(var doc in docs){
          try{
            orders.add(Order.fromJson(doc.data() as Map<String,dynamic>));
          }catch(e,s){
            _logger.error("getOrders - Invalid json order", error: e, stackTrace: s);
          }
        }
      }
      return orders;
    } catch (e,s) {
      _logger.error("getOrders", error: e, stackTrace : s);
    }
    return null;
  }


  
}
