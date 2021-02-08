import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/res/colors.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/wishlist/model/wish_list_model.dart';

class WishListController {
  static List<WishListModel> productList = new List();
  // static var wishListModelList = new List<WishListModel>().obs;

  static Future<void> fetchWishListItems(id, token) async {
    try {
      String url =
          "${GlobalData.baseUrl}${GlobalData.getWishListUrl}&cust_id=$id&cust_token=$token";
      print("URL WR $url");
      final response = await http.get(url);
      print("Response $response");
      var data = jsonDecode(response.body);
      print("DATAWWWW   $data");
      List<dynamic> list = data['data']
          .map((result) => new WishListModel.fromJson(result))
          .toList();
      print("LIST Category  $list");
      productList.clear();
      for (int b = 0; b < list.length; b++) {
        WishListModel wishListModel = list[b] as WishListModel;
        productList.add(wishListModel);
        print("Amenities ${wishListModel.pName}");
      }
      // Paging
    } catch (e) {
      print("Exception___Cat_____$e}");
    }
  }

  static String addStatus = "false";

  static Future<String> addToWishList(userId, pId, qQty) async {
    addStatus = "false";
    Map payload = {
      "cust_id": "$userId",
      "p_id": "$pId",
      "q_qty": "$qQty",
    };

    print("Payload  $payload");

    String url = "${GlobalData.baseUrl}${GlobalData.addToWishListUrl}";
    print("$url");
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

    print("RES  $data");

    if (data['status'] == true) {
      try {
        print("DAATA______________$data");
        addStatus = data['data'];
      } catch (e) {
        addStatus = "false";
        print("Exception I Store_______$e");
      }
    } else {
      addStatus = "false";
    }
    return addStatus;
  }

  static String deleteStatus = "false";

  static deleteWishList(
    userId,
    token,
    pId,
  ) async {
    deleteStatus = "false";
    String url =
        "${GlobalData.baseUrl}${GlobalData.removeFromWishListUrl}&cust_id=$userId&cust_token=$token&p_id=$pId";
    print("URL R $url");
    var responseData = await http.get(url);
    print('response.body fsd' + responseData.body);
    if (responseData.statusCode == 200) {
      print("Uploaded! ");
      var data = jsonDecode(responseData.body);
      if (data['data'].toString() == "true") {
        deleteStatus = "true";
      } else {
        deleteStatus = "false";
      }
      print("SSSS SSSS $deleteStatus");
    }
    print('response.body ' + responseData.body);
    return deleteStatus;
  }

  static showInSnackBar(String value, context, bgColor, textColor) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: MyColors.darkBlue)),
        backgroundColor: bgColor,
        content: new Text(
          value,
          style: TextStyle(color: textColor),
        )));
  }
}
