import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/wishlist/wish_list_view.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  child: new Text(
                    "WishList",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: 32),
                  ),
                ),
                Divider(
                  color: colorScheme.onSurface,
                  thickness: 1,
                  height: 2,
                ),
                new Expanded(child: WishListView())
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
}
