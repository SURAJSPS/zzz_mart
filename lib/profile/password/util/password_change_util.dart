
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/res/global_data.dart';

class PasswordChangeUtil{
  static updatePassword(context, uId, oldPass, newPass) async {

    Map payload = {
      "cust_id": uId,
      "oldpassword": oldPass,
      "newpassword": newPass
    };

    try{
      var url =
          '${GlobalData.baseUrl}${GlobalData.changePassUrl}';
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
      print("____Updated Saved___$data");

      if (data["status"] == "true") {
        print("MESSAGE ${data['message']}");
        GlobalData.showInSnackBar("${data['message']}", context, Colors.white, Colors.green, CupertinoIcons.checkmark_seal_fill, Colors.green);
        return "true";
      }else {
        print("MESSAGE Else ${data['message']}");
        GlobalData.showInSnackBar("${data['message']}", context, Colors.white, Colors.red, CupertinoIcons.info_circle_fill, Colors.red);
        return "false";
      }
    }catch(e){
      print("Exc $e");
      return "false";
    }
  }
}
