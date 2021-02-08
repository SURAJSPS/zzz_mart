import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/auth/login/otp/otp_page.dart';
import 'package:zzzmart/auth/login/util/login_controller.dart';

class PhoneView extends StatefulWidget {
  @override
  _PhoneViewState createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  TextEditingController phoneController = new TextEditingController();
  // TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.find();
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  String pattern =
      r'(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)';
  RegExp regExp;
  @override
  void initState() {
    // TODO: implement initState
    regExp = new RegExp(pattern);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Container(
      width: size.width,
      height: size.height,
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: new Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: new Form(
            key: _formKey,
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: new SizedBox(
                    height: 50,
                    child: CupertinoTextField(
                      controller: phoneController,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: colorScheme.primary, width: 1),
                          color: colorScheme.onPrimary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      textAlignVertical: TextAlignVertical.center,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      prefixMode: OverlayVisibilityMode.editing,
                      prefix: new Container(
                        width: 35,
                        alignment: Alignment.center,
                        child: new Icon(
                          CupertinoIcons.person,
                          size: 16,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      style: TextStyle(fontSize: 20),
                      placeholder: "Enter Email Or Mobile",
                      maxLines: 1,
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: RoundedLoadingButton(
                    color: colorScheme.secondary,
                    child: Text('Send OTP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900)),
                    controller: _btnController,
                    onPressed: () {
                      _btnController.start();
                      onGetOtpTap(context);
                    },
                  ),
                ),
                new SizedBox(
                  height: 50,
                )
              ],
            )),
      ),
    );
  }

  onGetOtpTap(_context) async {
    if (regExp.hasMatch(phoneController.text)) {
      bool isSend = await loginController.sendOtp(phoneController.value.text);
      if (isSend) {
        _btnController.success();
        Timer(Duration(seconds: 1), () {
          _btnController.reset();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OTPPage(phoneController.value.text)));
        });
      } else {
        Scaffold.of(_context).showSnackBar(new SnackBar(
          content: new Text(
            'Failed to send OTP!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: new Duration(seconds: 3),
        ));
      }
    }else{
      _btnController.reset();
      Scaffold.of(context).showSnackBar(new SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: new Text("Please Enter a valid Mobile!")));
    }
  }

}
