import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/cart/controller/local_cart.dart';
import 'package:zzzmart/cart/model/local_cart_model.dart';
import 'package:zzzmart/res/global_data.dart';

class LoginController extends GetxController {
  var userModelList = new List<UserModel>().obs;
  var status = "false".obs;

  @override
  void onInit() {
    super.onInit();
  }

  fetchLoginUser(email, password, context) async {
    print("LL_____________________$email ___ $password ___$context");
    Map payload = {'emailormobile': email, 'password': password};
    print("wwwwwwwwwwwww $email $password");

    String url = "${GlobalData.baseUrl}${GlobalData.loginWithIdPasswordUrl}";

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: payload,
      encoding: Encoding.getByName("utf-8"),
    );
    print("Response User_______${response.statusCode}");
    if (response.statusCode == 200) {
      var data;
      try {
        data = jsonDecode(response.body);
        print("All User Data_______$data");
        userModelList.clear();
        if (data['status'] == "true") {
          List<dynamic> list = data['data']
              .map((result) => new UserModel.fromJson(result))
              .toList();
          if (list.length > 0) {
            userModelList.clear();
            CurrentUser.saveCurrentUser("user", data);
            UserModel userModel = list[0] as UserModel;
            userModelList.add(userModel);
            status.value = "true";
            addToCart(userModel);
          } else {
            status.value = "false";
            GlobalData.showInSnackBar("${data['message']}", context, Colors.red,
                Colors.white, CupertinoIcons.info_circle_fill, Colors.white);
          }
          print("All Top Stores Model_______$userModelList");
        } else {
          print("DATA_______$data");
          GlobalData.showInSnackBar("${data['message']}", context, Colors.red,
              Colors.white, CupertinoIcons.info_circle_fill, Colors.white);
          status.value = "false";
        }
      } catch (e) {
        status.value = "false";
        GlobalData.showInSnackBar("${data['message']}", context, Colors.red,
            Colors.white, CupertinoIcons.info_circle_fill, Colors.white);
        print("Exception I Store_______$e");
      }
    } else {
      userModelList.clear();
      GlobalData.showInSnackBar("Internal Server Error!", context, Colors.red,
          Colors.white, CupertinoIcons.info_circle_fill, Colors.white);
      status.value = "false";
    }
    return status.value;
  }

  addToCart(UserModel userModel) async {
    var listOfMaps = List<Map<String, dynamic>>();
    List<LocalCartModel> cartList = await LocalCart.read();
    for (var i = 0; i < cartList.length; i++) {
      var keyValuePair = {
        'cust_id': userModel.id,
        'p_qty': cartList[i].pQty,
        'p_id': cartList[i].pId
      };
      listOfMaps.add(keyValuePair);
    }
    Map payload = {
      'result': listOfMaps,
    };

    String url = "${GlobalData.baseUrl}${GlobalData.addWishListInBulkUrl}";

    var data = json.encode(payload);

    print("DDDDDDD $data");

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data,
      encoding: Encoding.getByName("utf-8"),
    );

    print("Bulk WishList Response $response");

    var res = jsonDecode(response.body);

    print("Payload $res");
  }

  Future<bool> sendOtp(mobile) async {
    Map payload = {'cust_phone': mobile};
    var url =
        '${GlobalData.baseUrl}${GlobalData.sendOtpUrl}';
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
    print("DATA $data");

    if (data['status'] == "true") {
      return true;
    } else {
      return false;
    }
  }

  void showInSnackBar(String value, context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: new Text(value)));
  }
}
