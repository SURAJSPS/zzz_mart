import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzzmart/cart/model/local_cart_model.dart';

class LocalCart {
  static List<dynamic> cartList = new List();
  static List<LocalCartModel> list = new List();
  static bool status = false;

  static Future<List<LocalCartModel>> read() async {
    status = false;
    cartList.clear();
    list.clear();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("cart")) {
      cartList = json.decode(prefs.getString("cart"));
      for (var i = 0; i < cartList.length; i++) {
        LocalCartModel localCartModel = new LocalCartModel(cartList[i][0],
            cartList[i][1], cartList[i][2], cartList[i][3], cartList[i][4]);
        list.add(localCartModel);
      }
    } else {
      print("Empty List");
    }
    status = true;
    return list;
  }

  static save(
      String id, String title, String image, String price, String qty) async {
    List<dynamic> newList = new List();
    List<dynamic> oldList = new List();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("cart")) {
      newList = json.decode(prefs.getString("cart"));
    } else {
      print("Empty List");
    }
    List<String> bookmarkPost = [id, title, image, price, qty];
    oldList.add(bookmarkPost);
    newList.addAll(oldList);
    print("Cart List ___________________ $newList");
    prefs.setString("cart", json.encode(newList));
  }

  static remove(String id) async {
    List<dynamic> deleteList = new List();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("cart")) {
      deleteList = json.decode(prefs.getString("cart"));
      for (int b = 0; b < deleteList.length; b++) {
        if (deleteList[b][0] == id) {
          deleteList.removeAt(b);
        }
      }
      prefs.setString("cart", json.encode(deleteList));
    } else {
      print("Empty List");
    }
    read();
  }
}
