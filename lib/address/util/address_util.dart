import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/address/model/address_model.dart';
import 'package:zzzmart/address/util/address_controller.dart';
import 'package:zzzmart/res/global_data.dart';

final AddressController addressController = Get.find();

class AddressUtil {
  static List<dynamic> addressList = new List();
  static String status = "";

  static fetchAddress(context, uId, uToken) async {
    status = "";
    addressList.clear();

    Map payload = {'cust_id': uId, 'cust_token': uToken};

    var url = '${GlobalData.baseUrl}${GlobalData.getAddressUrl}';
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
    try {
      if (data["status"] == "true" && data['data'] != null) {
        addressList = data['data']
            .map((result) => new AddressModel.fromJson(result))
            .toList();
        addressController.addressObjectList.clear();
        for (int b = 0; b < addressList.length; b++) {
          AddressModel addressModel = addressList[b] as AddressModel;
          addressController.addressObjectList.add(addressModel);
          if (b == 0) {
            addressController.currentAddressIndex.value = b.toString();
          }
        }
        print("Orders__________${addressController.addressObjectList.length}");
      } else {
        print("DATA_______$data");
      }
      status = data['status'];
    } catch (e) {
      status = data['status'];
      print("Exception I_______$e");
    }
  }

  static Future<String> saveAddress(
      uId, uToken, address, landmark, city, phone, pin) async {
    Map payload = {
      'cust_id': uId,
      'cust_token': uToken,
      'cust_address': address,
      'cust_landmark': landmark,
      'cust_city': city,
      'cust_phone': phone,
      'pincode': pin
    };
    var url = '${GlobalData.baseUrl}${GlobalData.addAddressUrl}';
    print("$url");
    print("$payload");
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

    if (data['status'] == "true") {
      return "true";
    } else {
      return "false";
    }
  }

  static Future<String> updateAddress(
      id, uId, token, address, landmark, city, pin, phone) async {
    Map payload = {
      'sipping_id': id,
      'cust_id': uId,
      'cust_token': token,
      'address': address,
      'cust_landmarks': landmark,
      'cust_citys': city,
      'cust_phones': phone,
      'pincode': pin
    };

    var url = '${GlobalData.baseUrl}${GlobalData.updateAddressUrl}';
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

    if (data['status'] == "true") {
      return "true";
    } else {
      return "true";
    }
  }

  static Future<String> deleteAddress(context, id) async {
    Map payload = {'sipping_id': id};
    var url = '${GlobalData.baseUrl}${GlobalData.deleteAddressUrl}';
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
    print("___________$data");
    if (data['status'] == "true") {
      print("_____________Added");
      return "true";
    } else {
      print("_____________Not Added");
      return "false";
    }
  }
}
