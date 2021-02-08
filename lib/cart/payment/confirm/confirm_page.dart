import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/address/model/address_model.dart';
import 'package:zzzmart/address/util/address_controller.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/cart/payment/confirm/util/checkout_util.dart';
import 'package:zzzmart/res/global_data.dart';

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final CartController cartController = Get.find();
  final AddressController addressPageController = Get.find();
  AddressModel addressModel;

  @override
  void initState() {
    addressModel = addressPageController.addressObjectList[
        int.parse("${addressPageController.currentAddressIndex.value}")];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: CupertinoNavigationBar(
        brightness: Brightness.light,
        leading: new Material(
          color: Colors.transparent,
          child: new IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        middle: new Text(
          "Confirm Order",
          style: TextStyle(color: colorScheme.primary),
        ),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new ListView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          children: [
            new Text(
              "Confirm Your Order",
              style: TextStyle(
                  color: colorScheme.secondaryVariant,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            new Text(
              "Please confirm your payment details and delivery address again!",
              style: TextStyle(
                  color: colorScheme.secondaryVariant,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            new SizedBox(
              height: 15,
            ),
            new Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: new Container(
                width: size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: colorScheme.secondary,
                        width: 1,
                        style: BorderStyle.solid)),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      "PRICE DETAIL",
                      style: new TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                    new Divider(
                      height: 25,
                      thickness: 1,
                      color: colorScheme.secondary,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          "Price (${cartController.totalCount} items)",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        new Text(
                          "₹${cartController.totalPrice}",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        )
                      ],
                    ),
                    new SizedBox(
                      height: 15,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          "Delivery Charge",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        new Text(
                          "₹0",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    new SizedBox(
                      height: 15,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          "Discounts",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        new Text(
                          "₹0",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    new SizedBox(
                      height: 15,
                    ),
                    new Divider(
                      height: 2,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          "Total Amount",
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        new Text(
                          "₹${cartController.totalPrice}",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        )
                      ],
                    ),
                    new SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              shadowColor: colorScheme.onSurface,
            ),
            new Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: new Container(
                width: size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: colorScheme.secondary,
                        width: 1,
                        style: BorderStyle.solid)),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Row(
                      children: [
                        new Text(
                          "Delivery Address",
                          style: new TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w800,
                              fontSize: 14),
                        ),
                        new GestureDetector(
                            child: new SizedBox(
                              height: 20,
                              width: 60,
                              child: new Text(
                                "Change",
                                style: TextStyle(
                                    color: colorScheme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            })
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    new Divider(
                      height: 25,
                      thickness: 1,
                      color: colorScheme.secondary,
                    ),
                    new Row(
                      children: [
                        new Text(
                          "Address: ",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        new Expanded(
                          child: new Text(
                            "${addressModel.city}, ${addressModel.landmark}, ${addressModel.city} - ${addressModel.zipCode}",
                            style: new TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    new Row(
                      children: [
                        new Text(
                          "Contact: ",
                          style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        new Expanded(
                          child: new Text(
                            "${addressModel.phone}",
                            style: new TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              shadowColor: colorScheme.onSurface,
            ),
            new SizedBox(
              height: 50,
            )
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (_context) => FloatingActionButton.extended(
          onPressed: () async{
            // GlobalData.showInSnackBar(
            //     "Please enter valid fields!",
            //     _context,
            //     Colors.red,
            //     Colors.white,
            //     CupertinoIcons.info_circle_fill,
            //     Colors.white);
            String status = await CheckoutUtil.saveOrderByCod(CurrentUser.currentUser.id, CurrentUser.currentUser.token, addressPageController.addressObjectList[int.parse(addressPageController.currentAddressIndex.value)].id);
            if(status == "true") {
              GlobalData.showInSnackBar(
                  "Order Placed Successfully!",
                  _context,
                  Colors.green,
                  Colors.white,
                  CupertinoIcons.checkmark_seal_fill,
                  Colors.white);
            }else{
              GlobalData.showInSnackBar(
                  "Failed to Order!",
                  _context,
                  Colors.red,
                  Colors.white,
                  CupertinoIcons.info_circle_fill,
                  Colors.white);
            }
            },
          label: new Text("Confirm"),
          icon: Icon(CupertinoIcons.checkmark_seal_fill),
        ),
      ),
    );
  }
}
