import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/res/global_data.dart';

class VerificationUtil {
  static List<dynamic> list = new List();
  static String status;

 static Future<bool> verifyOtp(mobile, otp, password) async {
      String firebaseToken = "empty";

    Map payload = {
      'cust_phone': mobile,
      'otp': otp};

    var url =
        '${GlobalData.baseUrl}/admin/ecommerce_api/customer-otp-verify.php';
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

    print("_________DATA_______$data");
    if (data['status'] == "true") {
      list.clear();
      list =
          data['data'].map((result) => new UserModel.fromJson(result)).toList();
      UserModel userModel = list[0] as UserModel;
      // CurrentUser.saveCurrentUser("user", data);
      CurrentUser.saveCurrentUser("user", list);
      CurrentUser.currentUser = userModel;
      return true;
    } else {
      return false;
    }
  }
}
