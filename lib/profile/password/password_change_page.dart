import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/profile/password/util/password_change_util.dart';

class PasswordChangePage extends StatefulWidget {
  final UserModel userModel;

  PasswordChangePage(this.userModel);
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  TextEditingController oldPassController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController passMatchController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          leading: new Material(
            color: Colors.transparent,
            child: new IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          middle: new Text(
            "Change Password",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        child: new Scaffold(
          body: new ListView(
            children: [
              new Form(
                key: _formKey,
                child: new Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: oldPassController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.verified_user),
                            hintText: "********",
                            labelText: "Old Password"),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          if (val.length < 6) {
                            return 'Password must be greater than 6 digit!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // Email Input
                      TextFormField(
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.verified_outlined),
                            hintText: "********",
                            labelText: "Password"),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          if (val.length < 6) {
                            return 'Password must be greater than 6 digit!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // Mobile Input
                      TextFormField(
                        controller: passMatchController,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.grey,
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.verified),
                            hintText: "********",
                            labelText: "Re-enter Password"),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          if (val.length < 6 ||
                              passController.value.text != val) {
                            return 'Password not match!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Builder(builder: (_context) => new Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                        child: RoundedLoadingButton(
                          color: Colors.black,
                          successColor: colorScheme.secondary,
                          child: Text('Change Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900)),
                          controller: _btnController,
                          errorColor: Colors.red,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              onUpdateClick(_context);
                            }else{
                              Timer(Duration(seconds: 1), () {
                                _btnController.reset();
                              });
                            }
                          },
                        ),
                      ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  onUpdateClick(_context) async {
    _btnController.start();
    String oldPassword = oldPassController.value.text;
    String password = passController.value.text;
    String isUpdated = await PasswordChangeUtil.updatePassword(_context,
        userModel.id, oldPassword, password);
    if (isUpdated == "true") {
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
      });
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } else {
      _btnController.error();
      Timer(Duration(seconds: 4), () {
        _btnController.reset();
      });
      print("Filed to Update");
    }
  }
}
