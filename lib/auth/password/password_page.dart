import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/password/util/password_util.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = new TextEditingController();
  BuildContext _context;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: true,
      appBar: new CupertinoNavigationBar(automaticallyImplyLeading: true, automaticallyImplyMiddle: false,),
      body: new Builder(builder: (BuildContext context) {
        _context = context;
        return new ListView(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          children: [
            new Container(
              alignment: Alignment.center,
              width: size.width,
              height: size.width*0.8,
              child: Image.network(
                "https://pos.supersolutions.in/img/Reset-password-person.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            new SizedBox(
              height: 50,
            ),
            new SizedBox(
              height: 50,
              child: new CupertinoTextField(
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                placeholder: "Email Address",
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(CupertinoIcons.mail),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                controller: emailController,
              ),
            ),
            new SizedBox(
              height: 35,
            ),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: RoundedLoadingButton(
                color: colorScheme.secondary,
                child: Text('Confirm',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900)),
                controller: _btnController,
                onPressed: () {
                  onChangeClick(context);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  onChangeClick(context) async {
    String emailPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp emailRegExp = new RegExp(emailPattern);

    String email = emailController.value.text.replaceAll(" ", "");
    if (emailRegExp.hasMatch(email)) {
      String status = await PasswordUtil.passwordChange(email, context);
      if (status == "true") {
        _btnController.success();
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: new Text("Your Password Changed Successfully!"),
                  content: new Text(
                      "Your new password is send on your register email. Please check and go for login."),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text("Cancel"),
                    )
                  ],
                ));
      } else {
        _btnController.error();
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
          content: new Text("Please Enter Correct Field!")));
    }
    // it to show a SnackBar.
  }
}
