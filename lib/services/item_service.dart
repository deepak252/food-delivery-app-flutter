import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery_app/models/cart.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/utils/location_utils.dart';
import 'package:food_delivery_app/utils/logger.dart';

class ItemService{
  static final _logger = Logger("ItemService");

  static final _itemDB = FirestoreService("items");
  static final _userDB = FirestoreService("users");

  // Only for Development
  static Future insertItems() async {
    try {
      for(int i=0;i<_data.length;i++){
        final item  = await _addLocation(_data[i]);
        if(item!=null){
          item.id = _itemDB.getRandomDocId();
          await _itemDB.setDoc(item.id, item.toJson());          
        }
        log("Items Remaining : ${_data.length-i-1}");
      }
      _logger.message("insertItems", "All Items Uploaded");
    } catch (e,s) {
      _logger.error("insertItems", error: e, stackTrace : s);
    }
  }

  static Future<List<Item>?> getItems() async {
    try {
      final docs = await _itemDB.getDocs(limit: 2);
      if(docs!=null){
        return docs.map((doc) => 
          Item.fromJson(doc.data() as Map<String,dynamic>
        )).toList();
      }
    } catch (e,s) {
      _logger.error("getItems", error: e, stackTrace : s);
    }
    return null;
  }

  static Future<List<Item>?> getSpecificItems(List<String> docIds) async {
    try {
      if(docIds.isEmpty){
        return [];
      }
      final docs = await _itemDB.getSpecificDocs(docIds);
      if(docs!=null){
        return docs.map((doc) => 
          Item.fromJson(doc.data() as Map<String,dynamic>
        )).toList();
      }
    } catch (e,s) {
      _logger.error("getItems", error: e, stackTrace : s);
    }
    return null;
  }

  static Future<Item?> getItem(String itemId) async {
    try {
      _itemDB.getDoc(itemId);
    } catch (e,s) {
      _logger.error("getItems", error: e, stackTrace : s);
    }
    return null;
  }

  

  // static Future<List<Item>?> addItemToCart(Cart cart) async {
  //   try {
  //     _itemDB.getDoc("oSXnsv4na28lnVA5nbpk");
  //   } catch (e,s) {
  //     _logger.error("getItems", error: e, stackTrace : s);
  //   }
  //   return null;
  // }

  // Only for Development
  static Future<Item?> _addLocation(Map<String, dynamic> jsonItem)async{
    try{
      final item = Item.fromJson(jsonItem);
      final loc = await LocationUtils.getCoordinatesFromAddress(
        item.location?.address
      );
      if(loc!=null){
        item.location!.lat = loc.latitude;
        item.location!.lng = loc.longitude;
      }else{
        throw "Invalid Location";
      }
      return item;
    }catch(e,s){
      _logger.error("addLocation", error: e, stackTrace: s);
    }
    return null;
  }
}


List<Map<String, dynamic>>  _data = [
  
];