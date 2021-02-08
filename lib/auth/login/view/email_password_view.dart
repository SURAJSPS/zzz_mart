import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/auth/login/util/login_controller.dart';
import 'package:zzzmart/auth/password/password_page.dart';
import 'package:zzzmart/navigation_page.dart';

class EmailPasswordView extends StatefulWidget {
  @override
  _EmailPasswordViewState createState() => _EmailPasswordViewState();
}

class _EmailPasswordViewState extends State<EmailPasswordView> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.find();
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Container(
      width: size.width,
      height: size.height,
      color: Colors.transparent,
      child: new Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: new Form(
          key: _formKey,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: new SizedBox(
                  height: 50,
                  child: CupertinoTextField(
                    controller: emailController,
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
                child: new SizedBox(
                  height: 50,
                  child: CupertinoTextField(
                    controller: passwordController,
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
                        CupertinoIcons.lock_shield,
                        size: 16,
                      ),
                    ),
                    placeholder: "Password",
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    style: TextStyle(fontSize: 20),
                    maxLines: 1,
                    maxLength: 15,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
              new Row(
                children: [
                  new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new SizedBox(
                          height: 50,
                          child: new CupertinoButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPasswordPage()));
                            },
                            child: new Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(
                    width: 15,
                  ),
                  new Expanded(
                    child: RoundedLoadingButton(
                      color: Colors.black,
                      successColor: colorScheme.secondary,
                      child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900)),
                      controller: _btnController,
                      errorColor: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          onLoginClick(context);
                        }
                      },
                    ),
                  )
                ],
              ),
              new SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  onLoginClick(context) async {
    String email = emailController.value.text.replaceAll(" ", "");
    String password = passwordController.value.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      String status =
      await loginController.fetchLoginUser(email, password, context);
      if (status == "true") {
        _btnController.success();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavigationPage()),
                (route) => false);
      } else {
        _btnController.start();
        Timer(Duration(seconds: 2), () {
          _btnController.error();
        });
        Timer(Duration(seconds: 4), () {
          _btnController.reset();
        });
      }
    } else {
      _btnController.reset();
      Scaffold.of(context).showSnackBar(new SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: new Text("Please Enter Email and Password!")));
    }
    // it to show a SnackBar.
  }
}
