import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

//One method used to save in shared prefrences with deferrent types
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);
  }

//one method for getting any value with any type from shared
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }
}
