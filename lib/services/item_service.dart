import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/utils/location_utils.dart';
import 'package:food_delivery_app/utils/logger.dart';

class ItemService{
  static final _logger = Logger("ItemService");

  static final _itemDB = FirestoreService("items");

  // Only for Development
  static Future insertItems() async {
    try {
      int success=0, failed=0;
      for(int i=0;i<_data.length;i++){
        final item  = await _addLocation(_data[i]);
        if(item!=null){
          item.id = _itemDB.getRandomDocId();
          await _itemDB.setDoc(item.id, item.toJson());     
          success++;     
        }else{
          failed++;
        }
        _logger.message("insertItems", "Items Remaining : ${_data.length-i-1}");
      }
      _logger.message("insertItems", "success : ${success}, failed : ${failed}");
    } catch (e,s) {
      _logger.error("insertItems", error: e, stackTrace : s);
    }
  }

  static Future<List<Item>?> getItems(String category) async {
    try {
      List<DocumentSnapshot<Object?>>? docs;

      if(category.isEmpty){
        docs = await _itemDB.getDocs(limit: 20);
      }else{
        docs = await _itemDB.getDocsWithCondition(
          "category",
          arrayContains: category,
          limit: 20
        );
      }
      List<Item> items = [];
      if(docs!=null){
        for(var doc in docs){
          try{
            items.add(Item.fromJson(doc.data() as Map<String,dynamic>));
          }catch(e,s){
            _logger.error("getItems - Invalid json items", error: e, stackTrace: s);
          }
        }
      }
      return items;
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
      List<Item> items = [];
      if(docs!=null){
        for(var doc in docs){
          try{
            items.add(Item.fromJson(doc.data() as Map<String,dynamic>));
          }catch(e,s){
            _logger.error("getSpecificItems - Invalid json items", error: e, stackTrace: s);
          }
        }
      }
      return items;
    } catch (e,s) {
      _logger.error("getItems", error: e, stackTrace : s);
    }
    return null;
  }

  static Future<bool> addItemReview({
    required String itemId,
    required ItemReview review, 
  }) async {
    try {
      
      final reviewJson = review.toJson();
      try {
        reviewJson["user"]?.remove("address");
        reviewJson["user"]?.remove("favItems");
        reviewJson["user"]?.remove("cartItems");
      } catch (e,s) {
        _logger.error("addItemReview", error: e, stackTrace : s);
      }
      log("ADDING REVIEW : $reviewJson");
      return await _itemDB.updateDoc(itemId, {
        "reviews": FieldValue.arrayUnion([reviewJson])
      });
    } catch (e,s) {
      _logger.error("addItemReview", error: e, stackTrace : s);
    }
    return false;
  }

  static Future<Item?> getSpecificItem(String itemId) async {
    try {
      final doc = await _itemDB.getDoc(itemId);
      if(doc!=null){
        return Item.fromJson(doc.data() as Map<String,dynamic>);
      }
    } catch (e,s) {
      _logger.error("getItem", error: e, stackTrace : s);
    }
    return null;
  }

  // Only for Development
  static Future<Item?> _addLocation(Map<String, dynamic> jsonItem)async{
    try{
      final item = Item.fromJson(jsonItem);
      final loc = await LocationUtils.getCoordinatesFromAddress(
        item.restaurantLocation?.completeAddress
      );
      if(loc!=null){
        final address = await LocationUtils.getAddressFromCoordinaties(
           loc.latitude, loc.longitude);
        address.completeAddress = item.restaurantLocation?.completeAddress;
        item.restaurantLocation = address;
      }else{
        throw "Invalid Location";
      }
      return item;
    }catch(e,s){
      _logger.error("addLocation", error: e, stackTrace: s);
    }
    return null;
  }

  // static Future<Item?> _addLocation(Map<String, dynamic> jsonItem)async{
  //   try{
  //     final item = Item.fromJson(jsonItem);
  //     final loc = await LocationUtils.getCoordinatesFromAddress(
  //       item.restaurantLocation?.address
  //     );
  //     if(loc!=null){
  //       item.restaurantLocation!.lat = loc.latitude;
  //       item.restaurantLocation!.lng = loc.longitude;
  //     }else{
  //       throw "Invalid Location";
  //     }
  //     return item;
  //   }catch(e,s){
  //     _logger.error("addLocation", error: e, stackTrace: s);
  //   }
  //   return null;
  // }
}


List<Map<String, dynamic>>  _data = []; 