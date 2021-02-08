import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/auth/update/update_page.dart';
import 'package:zzzmart/profile/password/password_change_page.dart';
import 'package:zzzmart/res/global_data.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool user = false;

  userLoggedIn() async {
    bool userLoggedIn = await GlobalData.userLoggedIn();
    setState(() {
      user = userLoggedIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    userLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: user
          ? new Column(
              children: [
                new Expanded(
                    child: new ListView(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  children: [
                    new SizedBox(
                      height: 15,
                    ),
                    getHeader(CurrentUser.getCurrentUser()),
                    new SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: colorScheme.onSurface,
                    ),
                    new Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoButton(
                            child: new ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: new Text(
                                "Account Update",
                                style: TextStyle(
                                    color: colorScheme.primary, fontSize: 14),
                              ),
                              subtitle: new Text(
                                "Tap to Edit Your Account",
                                style: TextStyle(
                                    color: colorScheme.secondaryVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: new Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: new Icon(
                                  CupertinoIcons.person_circle,
                                  size: 34,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdatePage(
                                        CurrentUser.getCurrentUser()),
                                  ));
                            }),
                        CupertinoButton(
                            child: new ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: new Text(
                                "Password",
                                style: TextStyle(
                                    color: colorScheme.primary, fontSize: 14),
                              ),
                              subtitle: new Text(
                                "Tap to Change Your Password",
                                style: TextStyle(
                                    color: colorScheme.secondaryVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: new Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: new Icon(
                                  CupertinoIcons.lock_shield,
                                  size: 34,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordChangePage(CurrentUser.currentUser),));
                            }),
                        CupertinoButton(
                            child: new ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: new Text(
                                "Notification",
                                style: TextStyle(
                                    color: colorScheme.primary, fontSize: 14),
                              ),
                              subtitle: new Text(
                                "Show Previous Notification",
                                style: TextStyle(
                                    color: colorScheme.secondaryVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: new Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: new Icon(
                                  CupertinoIcons.bell_circle,
                                  size: 34,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            onPressed: () {}),
                        CupertinoButton(
                            child: new ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: new Text(
                                "Share",
                                style: TextStyle(
                                    color: colorScheme.primary, fontSize: 14),
                              ),
                              subtitle: new Text(
                                "Share Application to Friends",
                                style: TextStyle(
                                    color: colorScheme.secondaryVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: new Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: new Icon(
                                  CupertinoIcons.arrowshape_turn_up_left_circle,
                                  size: 34,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            onPressed: () {}),
                        CupertinoButton(
                            child: new ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: new Text(
                                "Contact Us",
                                style: TextStyle(
                                    color: colorScheme.primary, fontSize: 14),
                              ),
                              subtitle: new Text(
                                "Any Inquiry Please Contact Us",
                                style: TextStyle(
                                    color: colorScheme.secondaryVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: new Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: new Icon(
                                  CupertinoIcons.phone_circle,
                                  size: 34,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            onPressed: () {}),
                      ],
                    )
                  ],
                )),
                new Container(
                  child: new CupertinoButton(
                    color: colorScheme.onSurface,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    borderRadius: BorderRadius.circular(0),
                    onPressed: () {
                      CurrentUser.removeKey("user");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: new Container(
                      width: size.width,
                      height: 40,
                      color: colorScheme.onSurface,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          new Icon(
                            CupertinoIcons.power,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          : new Container(
              child: new Center(
                child: CupertinoButton(
                  child: new Text("Login First"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                  color: colorScheme.secondary,
                ),
              ),
            ),
    );
  }

  getHeader(UserModel userModel) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Column(
      children: [
        new Container(
          alignment: Alignment.center,
          width: size.width,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: colorScheme.onSurface, width: 5),
                    color: colorScheme.onSurface),
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: userModel.image != null
                      ? Image.memory(
                          Base64Decoder().convert("${userModel.image}"),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                ),
              )
            ],
          ),
        ),
        new SizedBox(
          height: 15,
        ),
        new Text(
          "${userModel.name}",
          style: TextStyle(
              fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w900),
        ),
        new SizedBox(
          height: 5,
        ),
        new Text(
          "Email: ${userModel.email}",
          style: TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        new SizedBox(
          height: 5,
        ),
        new Text(
          "${userModel.address}",
          style: TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
