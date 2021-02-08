import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/login/otp/otp_util/otp_util.dart';
import 'package:zzzmart/auth/login/otp/widget/resend_button.dart';
import 'package:zzzmart/auth/login/otp/widget/verify_otp_button.dart';
import 'package:zzzmart/auth/login/util/login_controller.dart';
import 'package:zzzmart/home/home_page.dart';


class OTPPage extends StatefulWidget {
  final String mobile;
  OTPPage(this.mobile);
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  BuildContext _context;
  bool onPressedValue = true;
  Timer _timer;
  int _start = 30;
  TabController tabController;
  int currentTab = 0;
  // final PageController _pageController = PageController(initialPage: 1);
  // int _pageIndex = 0;
  final LoginController loginController = Get.find();

  void startTimer() {
    onPressedValue = false;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              onPressedValue = true;
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
            body: new Builder(builder: (BuildContext context) {
              _context = context;
              return new ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  // Title
                  new Text(
                    "Verifying your Mobile",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Description
                  new Text(
                    "We have sent 4 digit code on \n +91${widget.mobile}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  new Form(
                    key: _formKey,
                    child: justRoundedCornersPinPut(),
                  ),
                  // Resend
                  new Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ResendOtpButton(onResendOtpTap),
                              SizedBox(
                                width: 5,
                              ),
                              new Text(
                                "$_start",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                  VerifyOtpButton(onVerifyOtpTap),
                ],
              );
            })),
        onWillPop: _willPopCallback);
  }

  Widget justRoundedCornersPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: PinPut(
        fieldsCount: 6,
        textStyle: TextStyle(
            fontSize: 25.0, color: Theme.of(context).colorScheme.primary),
        eachFieldWidth: 40.0,
        eachFieldHeight: 40.0,
        onSubmit: (String pin) {
          print("PIN______________$pin");
        },
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        keyboardType: TextInputType.phone,
        pinAnimationType: PinAnimationType.fade,
      ),
    );
  }

  onVerifyOtpTap() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirst = prefs.getBool("is_first");
    bool isVerified = false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Center(
                child: CircularProgressIndicator(),
              ),
            ));
    if (currentTab == 0) {
      isVerified = await VerificationUtil.verifyOtp(
          widget.mobile, _pinPutController.value.text, "");
    } else {
      isVerified = await VerificationUtil.verifyOtp(
          widget.mobile, "", _passwordController.value.text);
    }
    Navigator.of(context).pop();
    if (isVerified) {
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
    } else {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text(
          'Faied to verify OTP or Passwrod!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: new Duration(seconds: 3),
      ));
    }
  }

  onResendOtpTap() {
    if (onPressedValue) {
      setState(() {
        _start = 30;
      });
      startTimer();
    }
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
    return true; // return true if the route to be popped
  }

  onGetOtpTap() async {
    if (_formKey.currentState.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Center(
                  child: CircularProgressIndicator(),
                ),
              ));
      bool isSended = await loginController.sendOtp(widget.mobile);
      Navigator.of(context).pop();
      if (isSended) {
        Scaffold.of(_context).showSnackBar(new SnackBar(
          content: new Text(
            'OTP Resend Successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: new Duration(seconds: 3),
        ));
      } else {
        Scaffold.of(_context).showSnackBar(new SnackBar(
          content: new Text(
            'Failed to Resend OTP!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: new Duration(seconds: 3),
        ));
      }
    }
  }
}
