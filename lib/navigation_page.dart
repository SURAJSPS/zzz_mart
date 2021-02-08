import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/cart/cart_page.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/home/home_page.dart';
import 'package:zzzmart/profile/profile_page.dart';
import 'package:zzzmart/storesLocator/stores_locator_page.dart';
import 'package:zzzmart/wishlist/wish_list_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // key: _scaffoldKey,
      // drawer: new Drawer(),
      appBar: AppBar(
        elevation: 1,
        brightness: Brightness.light,
        backgroundColor: colorScheme.onPrimary,
        leading: new Container(),
        title: Text(
          'ZZZ Mart',
          style: TextStyle(
            fontSize: 24,
            color: colorScheme.primary,
            fontWeight: FontWeight.w900,
            fontFamily: "cursive",
            shadows: <Shadow>[
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
                color: Color.fromARGB(25, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(5.0, 5.0),
                blurRadius: 8.0,
                color: Color.fromARGB(25, 0, 0, 25),
              ),
            ],
          ),
        ),
        leadingWidth: 1,
        actions: [
          // IconButton(
          //   icon: new Icon(
          //     CupertinoIcons.heart,
          //     color: colorScheme.primary,
          //   ),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: new Icon(
              CupertinoIcons.bag_badge_plus,
              color: colorScheme.primary,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ));
            },
          ),
          new SizedBox(
            width: 15,
          )
        ],
      ),
      body: getBody(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: colorScheme.onPrimary,
          selectedItemBorderColor: colorScheme.onSurface,
          selectedItemBackgroundColor: colorScheme.secondary,
          selectedItemIconColor: colorScheme.onPrimary,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: CupertinoIcons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.store,
            label: 'Stores',
          ),
          FFNavigationBarItem(
            iconData: CupertinoIcons.heart_slash_circle,
            label: 'Favourite',
          ),
          FFNavigationBarItem(
            iconData: CupertinoIcons.person_circle,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  getBody() {
    if (selectedIndex == 0) {
      return HomePage();
    } else if (selectedIndex == 1) {
      return new StoresLocatorPage();
      // return new Container();
    } else if (selectedIndex == 2) {
      return new WishListPage();
    } else if (selectedIndex == 3) {
      return new ProfilePage();
    }
  }
}
