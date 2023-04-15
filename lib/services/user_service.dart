import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/utils/logger.dart';

class UserService{
  static final _logger = Logger("UserService");
  static final _userDB = FirestoreService("users");

  static Future<User?> getUser(String userId) async {
    try {
      final doc = await _userDB.getDoc(userId);
      _logger.message("getUser", doc?.data());
      if(doc?.data()!=null){
        return User.fromJson(doc!.data() as Map<String, dynamic>);
      }
    } catch (e,s) {
      _logger.error("getUser", error: e, stackTrace : s);
    }
    return null;
  }

  static Future insertUser(User user) async {
    try {
      await _userDB.setDoc(user.id,user.toJson());    
      _logger.message("insertUser", "User Added to Database");
      return user;   
    } catch (e,s) {
      _logger.error("insertUser", error: e, stackTrace : s);
    }
  }

  static Future<bool> addItemToFav({
    required String userId, 
    required String itemId, 
    }) async {
    try {
      return await _userDB.updateDoc(userId, {
        "favItems": FieldValue.arrayUnion([itemId])
      });
    } catch (e,s) {
      _logger.error("addItemToFav", error: e, stackTrace : s);
    }
    return false;
  }

  static Future<bool> removeItemFromFav({
    required String userId, 
    required String itemId, 
    }) async {
    try {
      return await _userDB.updateDoc(userId, {
        "favItems": FieldValue.arrayRemove([itemId])
      });
    } catch (e,s) {
      _logger.error("remoteItemFromFav", error: e, stackTrace : s);
    }
    return false;
  }

  
}
