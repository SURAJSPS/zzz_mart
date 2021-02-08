import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/cart/model/cart_model.dart';
import 'package:zzzmart/res/global_data.dart';

class CartController extends GetxController {
  var totalCount = 0.obs;
  var totalPrice = 0.obs;
  var cartObjectList = new List();
  String status;
  static TextEditingController codeController = TextEditingController();

  fetchCart(context, cId, token) async {
    status = null;
    var data;
    String url =
        "${GlobalData.baseUrl}${GlobalData.getCartUrl}&cust_id=$cId&cust_token=$token";
    try {
      var response = await http.get(url);
      print("My CART URL $url");
      print("My CART R RES  $response");
      data = json.decode(response.body);
      print("My CART RES  $data");
      if (data['status'] == "true" || data['data'] != null) {
        var list = data['data']
            .map((result) => new CartModel.fromJson(result))
            .toList();
        cartObjectList.clear();
        totalCount.value = 0;
        totalPrice.value = 0;
        for (var i = 0; i < list.length; i++) {
          CartModel cartModel = list[i] as CartModel;
          cartObjectList.add(cartModel);
          totalCount = totalCount + int.parse(cartModel.pQty);
          totalPrice = totalPrice +
              (int.parse(cartModel.cCurrentPrice) * int.parse(cartModel.pQty));
          print("${cartObjectList.length} ppp");
        }
      } else {
        cartObjectList.clear();
        totalCount.value = 0;
        totalPrice.value = 0;
        print("DATA_______$data");
      }
    } catch (e) {
      cartObjectList.clear();
      totalCount.value = 0;
      totalPrice.value = 0;
      print("Exception IC_______$e");
    }
    status = "true";
  }

  Future<String> addToCart(
    context,
    uId,
    pId,
    pQty,
  ) async {
    Map payload = {'cust_id': uId, 'p_id': pId, 'p_qty': pQty};
    try {
      var url = '${GlobalData.baseUrl}${GlobalData.addToCartUrl}';

      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: payload,
        encoding: Encoding.getByName("utf-8"),
      );

      var data = jsonDecode(response.body);
      if (data['status'] == "true" && data['data'] == 'true') {
        print("_____________Added");
        return "true";
      } else {
        print("_____________Not Added");
        return "false";
      }
    } catch (e) {
      print("Exception______C_____$e");
      return "false";
    }
  }

  Future<String> deleteFromCart(context, uId, uToken, cId) async {
    var response = await http.get(
        "${GlobalData.baseUrl}${GlobalData.removeCartUrl}&cust_id=$uId&cust_token=$uToken&cart_id=$cId");
    print(
        "SASAS ${GlobalData.baseUrl}${GlobalData.removeCartUrl}&cust_id=$uId&cust_token=$uToken&cart_id=$cId");
    var data = jsonDecode(response.body);
    print("___________$data");
    if (data['status'] == "true") {
      print("_____________Deleted");
      return "true";
    } else {
      print("_____________Not Deleted");
      return "false";
    }
  }
}
