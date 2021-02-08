import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/res/global_data.dart';

class PasswordUtil {
  static var picker = ImagePicker();

  static var userModelList = new List<UserModel>();
  static var status = "false";

  static passwordChange(email, context) async {
    print("LL_____________________$email ___");
    Map payload = {
      "cust_email": email
    };
    String url = "${GlobalData.baseUrl}${GlobalData.passwordChangeUrl}";
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
          status = "true";
          showInSnackBar("Password Changed Successfully!", Colors.green, context);
        } else {
          print("DATA_______$data");
          showInSnackBar("${data['message']}", Colors.red, context);
          status = "false";
        }
      } catch (e) {
        status = "false";
        showInSnackBar("Failed to Change Password!", Colors.red, context);
        print("Exception I Store_______$e");
      }
    } else {
      userModelList.clear();
      showInSnackBar("Internal Server Error!", Colors.red, context);
      status = "false";
    }
    return status;
  }

  static void showInSnackBar(String value, color, context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: new Text(value)));
  }
}
