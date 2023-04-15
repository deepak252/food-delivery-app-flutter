import 'dart:convert';
import 'package:food_delivery_app/utils/logger.dart';
import 'package:get_storage/get_storage.dart';

class UserPrefs {
  static final _logger = Logger("UserPrefs");
  static final GetStorage _getStorage = GetStorage();

  static const String _userKey = 'USER_PROFILE';

  static String? get token =>   _getStorage.read(_userKey); 

  static Future setToken({required String value})async{
    await _getStorage.write(_userKey, value);
    _logger.message("setToken", value);
  }  

  static Future clearData() async{
    await _getStorage.erase();
    _logger.message("clearData", "Removed User Prefs");
  }

}