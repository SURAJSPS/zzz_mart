import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/address/model/address_model.dart';
import 'package:zzzmart/address/util/address_util.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/res/global_data.dart';

class UpdateAddressPage extends StatefulWidget {
  final AddressModel addressModel;

  UpdateAddressPage(this.addressModel);

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  // LocationResult _pickedLocation;
  BuildContext _context;
  UserModel userModel;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  final CartController cartController = Get.find();
  String mobilePattern =
      r"(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)";
  RegExp mobileRegExp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileRegExp = new RegExp(mobilePattern);
    addressController.text = widget.addressModel.address;
    landmarkController.text = widget.addressModel.landmark;
    cityController.text = widget.addressModel.city;
    pinCodeController.text = widget.addressModel.zipCode;
    mobileController.text = widget.addressModel.phone;
    getUser();
  }

  getUser() async {
    userModel = await CurrentUser.fetchCurrentUser();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      appBar: new CupertinoNavigationBar(
        leading: new Material(
          elevation: 0,
          color: Colors.transparent,
          child: new IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: new Icon(
              CupertinoIcons.back,
              color: colorScheme.primary,
            ),
          ),
        ),
        middle: new Text(
          "Update Address",
          style: TextStyle(color: colorScheme.primary),
        ),
      ),
      body: new Builder(builder: (BuildContext context) {
        _context = context;
        return new ListView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          children: [
            new Container(
              width: size.width,
              child: new Text(
                "Update Address",
                style: TextStyle(
                    color: colorScheme.secondaryVariant,
                    fontSize: 38,
                    fontWeight: FontWeight.w800),
              ),
              padding: EdgeInsets.all(10),
            ),
            new SizedBox(
              height: 10,
            ),
            new Text(
              "Note: All fields are mandatory.*",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
            ),
            new SizedBox(
              height: 10,
            ),
            new Form(
              child: new Column(
                children: [
                  new SizedBox(
                    height: 80,
                    child: new CupertinoTextField(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(5)),
                      placeholder: "Address",
                      minLines: 2,
                      maxLines: 2,
                      keyboardType: TextInputType.streetAddress,
                      prefix: new Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: new Icon(Icons.location_city_rounded),
                      ),
                      prefixMode: OverlayVisibilityMode.editing,
                      controller: addressController,
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  new SizedBox(
                    height: 60,
                    child: new CupertinoTextField(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(5)),
                      placeholder: "Land Mark",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      prefix: new Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: new Icon(CupertinoIcons.map_pin_ellipse),
                      ),
                      prefixMode: OverlayVisibilityMode.editing,
                      controller: landmarkController,
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  new SizedBox(
                    height: 60,
                    child: new CupertinoTextField(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(5)),
                      placeholder: "City",
                      maxLines: 1,
                      prefix: new Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: new Icon(CupertinoIcons.location_circle),
                      ),
                      prefixMode: OverlayVisibilityMode.editing,
                      keyboardType: TextInputType.name,
                      controller: cityController,
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  new SizedBox(
                    height: 60,
                    child: new CupertinoTextField(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(5)),
                      placeholder: "Mobile No.",
                      maxLines: 1,
                      prefix: new Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: new Icon(CupertinoIcons.phone_circle),
                      ),
                      prefixMode: OverlayVisibilityMode.editing,
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      maxLength: 10,
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  new SizedBox(
                    height: 60,
                    child: new CupertinoTextField(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(5)),
                      placeholder: "ZIP Code",
                      maxLines: 1,
                      prefix: new Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: new Icon(Icons.my_location_rounded),
                      ),
                      prefixMode: OverlayVisibilityMode.editing,
                      keyboardType: TextInputType.phone,
                      controller: pinCodeController,
                      maxLength: 6,
                    ),
                  ),
                  new SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
            new SizedBox(
              height: 15,
            ),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: RoundedLoadingButton(
                color: Colors.black,
                successColor: colorScheme.secondary,
                child: Text('Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900)),
                controller: _btnController,
                errorColor: Colors.red,
                onPressed: () {
                  bool isValid = getValidate(_context);
                  if (isValid) {
                    saveAddressNow(_context);
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  bool getValidate(_context) {
    if (addressController.text.isNotEmpty &&
        landmarkController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        pinCodeController.text.isNotEmpty &&
        mobileRegExp.hasMatch(mobileController.text)) {
      return true;
    } else {
      _btnController.reset();
      GlobalData.showInSnackBar(
          "Please enter valid fields!",
          _context,
          Colors.red,
          Colors.white,
          CupertinoIcons.info_circle_fill,
          Colors.white);
      return false;
    }
  }

  saveAddressNow(_context) async {
    String address = addressController.value.text;
    String street = landmarkController.value.text;
    String city = cityController.value.text;
    String pin = pinCodeController.value.text;
    String mobile = mobileController.value.text;

    String status = await AddressUtil.updateAddress(widget.addressModel.id,
        userModel.id, userModel.token, address, street, city, pin, mobile);
    if (status == "true") {
      addressController.clear();
      landmarkController.clear();
      cityController.clear();
      pinCodeController.clear();
      mobileController.clear();
      _btnController.success();
      GlobalData.showInSnackBar(
          "Address Updated Successfully!",
          _context,
          Colors.green,
          Colors.white,
          CupertinoIcons.checkmark_seal_fill,
          Colors.white);
      await AddressUtil.fetchAddress(_context, userModel.id, userModel.token);
      Navigator.of(context).pop();
    } else {
      _btnController.error();
      Timer(Duration(seconds: 2), () {
        _btnController.error();
      });
      Timer(Duration(seconds: 4), () {
        _btnController.reset();
      });
      GlobalData.showInSnackBar(
          "Failed to Update Address!",
          _context,
          Colors.red,
          Colors.white,
          CupertinoIcons.info_circle_fill,
          Colors.white);
    }
  }
}
