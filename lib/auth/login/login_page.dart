import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/auth/login/util/login_controller.dart';
import 'package:zzzmart/auth/login/view/email_password_view.dart';
import 'package:zzzmart/auth/login/view/phone_view.dart';
import 'package:zzzmart/auth/registration/resgister_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext _context;
  bool isOtpLogin = true;
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: SafeArea(child: new Builder(builder: (BuildContext context) {
        _context = context;
        return new Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          width: size.width,
          height: size.height,
          child: new Column(
            children: [
              SizedBox(height: 15,),
              new Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.width*0.5,
                child: Image.network(
                  "https://www.papertax.in/assets/images/user/login.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              new Expanded(
                child: new Container(
                  alignment: Alignment.bottomCenter,
                  color: colorScheme.onPrimary,
                  child: !isOtpLogin ? PhoneView() : EmailPasswordView(),
                ),
              ),
              new Column(
                children: [
                  new SizedBox(
                    height: 50,
                    width: size.width,
                    child: new RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          isOtpLogin = !isOtpLogin;
                        });
                      },
                      label: new Text(
                        isOtpLogin
                            ? 'Login with OTP'
                            : 'Login with Id Password?',
                        style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                      icon: Icon(
                        isOtpLogin
                            ? CupertinoIcons.phone_circle
                            : CupertinoIcons.lock_shield,
                        size: 20,
                        color: colorScheme.onPrimary,
                      ),
                      color: isOtpLogin ? colorScheme.secondary : Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  new SizedBox(
                    height: 15,
                  ),
                  new SizedBox(
                    height: 50,
                    width: size.width,
                    child: new RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      label: new Text(
                        'New Registration',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                      icon: Icon(
                        CupertinoIcons.pencil_circle,
                        size: 20,
                        color: Colors.black,
                      ),
                      color: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'By Continue, to agree our\n',
                        style: TextStyle(
                            color: colorScheme.secondaryVariant, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                                color: colorScheme.secondary, fontSize: 14),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(
                                color: colorScheme.secondaryVariant,
                                fontSize: 14),
                          ),
                          TextSpan(
                            text: 'Conditions',
                            style: TextStyle(
                                color: colorScheme.secondary, fontSize: 14),
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              )
            ],
          ),
        );
      }),),
    );
  }
}
