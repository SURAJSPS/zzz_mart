import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzzmart/auth/model/user_model.dart';

class CurrentUser {
  static UserModel currentUser;

  static getCurrentUser() {
    fetchCurrentUser();
    return currentUser;
  }

  static fetchCurrentUser() async {
    currentUser = await readCurrentUser("user");
    return currentUser;
  }

  static Future<UserModel> readCurrentUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString(key) != null) {
        var data = json.decode(prefs.getString(key));
        var list = data['data']
            .map((result) => new UserModel.fromJson(result))
            .toList();
        UserModel userModel = list[0] as UserModel;
        currentUser = userModel;
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception_______$e");
      return null;
    }
  }

  static saveCurrentUser(String key, value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, json.encode(value));
    } catch (e) {
      print("Exception_______$e");
    }
  }

  static removeKey(key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static saveInitialize(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, value);
    } catch (e) {
      print("Exception_______$e");
    }
  }

  static Future<bool> readInitialize(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    } catch (e) {
      print("Exception_______$e");
      return false;
    }
  }
}
