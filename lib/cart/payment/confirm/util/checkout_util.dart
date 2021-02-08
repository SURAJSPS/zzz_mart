import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/res/global_data.dart';

class CheckoutUtil {
  static saveOrderByCod(uId, uToken, addressId) async {
    print("Debuygg $uId, $uToken, $addressId");
    Map payload = {
      "cust_id": "$uId",
      "cust_token": uToken,
      "cust_address_id": "645"
    };

    try{
      var url =
          '${GlobalData.baseUrl}${GlobalData.codCheckoutUrl}';
      print("!!!!!!!!!!!");
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: payload,
        encoding: Encoding.getByName("utf-8"),
      );
      print("0001222__${response.body}");
      print("0001111__${jsonDecode(response.body)}");
      if (response.body.isNotEmpty) {
        var map = jsonDecode(response.body);
        print("0000000000000000__$map");
        if (map['status'] == "true") {
          return "true";
        } else {
          print("Failed to send!");
          return "false";
        }
      } else {
        print("Empty Body");
        return "false";
      }
    }catch(e){
      print("Exception_____$e");
      return "false";
    }
  }

  static Future<bool> saveOrderAddress(
      uId, slot, address, orderId, context) async {
    Map payload = {
      "cust_id": uId,
      "address": address,
      "time_slot": slot,
      "order_id": orderId,
    };

    var url =
        '${GlobalData.baseUrl}/admin/ecommerce_api/location/order-address.php';
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

    print("____Address Saved___$data");

    if (data["status"] == "200") {
      return true;
    }else {
      return false;
    }
  }

  static saveOrderNow(context, id, name, email, amount, orderId, paymentId, address, timeSlot, method) async {
    print("____I__ $id __N__ $name ___E_____ $email __A_____ $amount __O_____ $orderId ___P___ $paymentId __A___$address __T__$timeSlot __M___ $method");
    // bool isOrderSaved = await saveOrder(id, name, email, orderId, amount, paymentId, method);
    Navigator.of(context).pop();
    if(true){
      bool isAddressSaved = await saveOrderAddress(id, timeSlot, address, orderId, context);
      if(isAddressSaved){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Column(
                children: [
                  new Icon(Icons.check_circle, color: Colors.green, size: 70,),
                  new Text("TNX Id : $paymentId")],
              ),
              content: new Text("Order Placed Successfully! We are very Thankful for your order!"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Ok"),
                  onPressed: () async {
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                  },
                ),
              ],
            ));
      }else{
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Column(
                children: [
                  new Icon(Icons.error, color: Colors.green, size: 70,),
                  new Text("TNX Id : $paymentId")],
              ),
              content: new Text("Failed to place your order now. Please claim if your amount is deducted!"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Ok"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
    }else{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Column(
              children: [
                new Icon(Icons.error, color: Colors.green, size: 70,),
                new Text("TNX Id : $paymentId")],
            ),
            content: new Text("Failed to place your order now. Please claim if your amount is deducted!"),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }
  }
}
