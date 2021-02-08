import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/cart/controller/local_cart.dart';
import 'package:zzzmart/cart/payment/address_page.dart';
import 'package:zzzmart/cart/widget/cart_item_card.dart';
import 'package:zzzmart/cart/widget/local_cart_item.dart';
import 'package:zzzmart/navigation_page.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/res/my_loader.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BuildContext scaffoldContext;
  // Future activePlan;
  UserModel userModel;
  bool user = false;

  userLoggedIn() async {
    bool userLoggedIn = await GlobalData.userLoggedIn();
    userModel = await CurrentUser.fetchCurrentUser();
    setState(() {
      user = userLoggedIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userLoggedIn();
    CartController.codeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return new Material(
      child: new CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          brightness: Brightness.light,
          leading: new Material(
            color: Colors.transparent,
            child: new IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          middle: new Text(
            "My Cart",
            style: TextStyle(color: colorScheme.primary),
          ),
        ),
        child: new Scaffold(
          body: SafeArea(child: new Builder(builder: (BuildContext context) {
            scaffoldContext = context;
            return user
                ? new Column(
                    children: [
                      new Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 50),
                          physics: ScrollPhysics(),
                          children: [
                            new FutureBuilder(
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (cartController.status != "true" &&
                                      cartController.cartObjectList.length ==
                                          0) {
                                    return Center(
                                      child: new MyLoader(),
                                    );
                                  } else if (cartController.status == "true" &&
                                      cartController.cartObjectList.length ==
                                          0) {
                                    return Container(
                                      height: size.height,
                                      width: size.width,
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          new Icon(
                                            CupertinoIcons.cart,
                                            size: 120,
                                            color: colorScheme.primary,
                                          ),
                                          new SizedBox(
                                            height: 15,
                                          ),
                                          new Text("Your Cart is empty !."),
                                          new SizedBox(
                                            height: 50,
                                          ),
                                          new Container(
                                            child: new CupertinoButton(
                                              color: colorScheme.primary,
                                              child:
                                                  new Text("Continue Shopping"),
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NavigationPage()),
                                                    (route) => false);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Obx(() => new Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: cartController
                                                  .cartObjectList.length,
                                              itemBuilder:
                                                  (context, int index) {
                                                return new CartItemCard(
                                                    cartController
                                                        .cartObjectList[index]);
                                              },
                                            ),
                                            // Empty Cart----------------
                                            cartController.cartObjectList
                                                        .length ==
                                                    0
                                                ? Container(
                                                    height: size.height,
                                                    width: size.width,
                                                    child: new Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        new Icon(
                                                          CupertinoIcons.cart,
                                                          size: 120,
                                                          color: colorScheme
                                                              .primary,
                                                        ),
                                                        new SizedBox(
                                                          height: 15,
                                                        ),
                                                        new Text(
                                                            "Your Cart is empty."),
                                                        new SizedBox(
                                                          height: 50,
                                                        ),
                                                        new Container(
                                                          child:
                                                              new CupertinoButton(
                                                            color: colorScheme
                                                                .primary,
                                                            child: new Text(
                                                                "Continue Shopping"),
                                                            onPressed: () {
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              NavigationPage()),
                                                                  (route) =>
                                                                      false);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                // Price Details ---------------------------------------
                                                : new Card(
                                                    elevation: 2,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 15),
                                                    child: new Container(
                                                      width: size.width,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade50,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: colorScheme
                                                                  .secondary,
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      child: new Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          new Text(
                                                            "PRICE DETAIL",
                                                            style: new TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 14),
                                                          ),
                                                          new SizedBox(
                                                            height: 10,
                                                          ),
                                                          new Divider(
                                                            height: 2,
                                                            color: colorScheme
                                                                .secondary,
                                                          ),
                                                          new SizedBox(
                                                            height: 15,
                                                          ),
                                                          new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              new Text(
                                                                "Price (${cartController.totalCount} items)",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              new Text(
                                                                "₹${cartController.totalPrice}",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            ],
                                                          ),
                                                          new SizedBox(
                                                            height: 15,
                                                          ),
                                                          new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              new Text(
                                                                "Delivery Charge",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              new Text(
                                                                "₹0",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          ),
                                                          new SizedBox(
                                                            height: 15,
                                                          ),
                                                          new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              new Text(
                                                                "Discounts",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              new Text(
                                                                "₹0",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          ),
                                                          new SizedBox(
                                                            height: 15,
                                                          ),
                                                          new Divider(
                                                            height: 2,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          new SizedBox(
                                                            height: 10,
                                                          ),
                                                          new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              new Text(
                                                                "Total Amount",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              new Text(
                                                                "₹${cartController.totalPrice}",
                                                                style: new TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        18),
                                                              )
                                                            ],
                                                          ),
                                                          new SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    shadowColor:
                                                        colorScheme.onSurface,
                                                  ),
                                          ],
                                        ));
                                  }
                                },
                                future: cartController.fetchCart(
                                    context, userModel.id, userModel.token))
                          ],
                        ),
                      ),
                    ],
                  )
                : new Column(
                    children: [
                      new Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 50),
                          physics: ScrollPhysics(),
                          children: [
                            new FutureBuilder(
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (LocalCart.list.length == 0) {
                                    return Center(
                                      child: new Container(),
                                    );
                                  } else if (LocalCart.list.length == 0) {
                                    return Container(
                                      height: size.height,
                                      width: size.width,
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          new Icon(
                                            CupertinoIcons.cart,
                                            size: 120,
                                            color: colorScheme.primary,
                                          ),
                                          new SizedBox(
                                            height: 15,
                                          ),
                                          new Text("Your Cart is empty."),
                                          new SizedBox(
                                            height: 50,
                                          ),
                                          new Container(
                                            child: new CupertinoButton(
                                              color: colorScheme.primary,
                                              child:
                                                  new Text("Continue Shopping"),
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NavigationPage()),
                                                    (route) => false);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    return new Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: LocalCart.list.length,
                                          itemBuilder: (context, int index) {
                                            return new LocalCartItem(
                                                LocalCart.list[index]);
                                          },
                                        ),
                                        new SizedBox(
                                          height: 15,
                                        ),
                                        CupertinoButton(
                                          child: new Text("Login to Checkout"),
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage(),
                                                ),
                                                (route) => false);
                                          },
                                          color: colorScheme.secondary,
                                        )
                                      ],
                                    );
                                  }
                                },
                                future: LocalCart.read())
                          ],
                        ),
                      ),
                    ],
                  );
          })),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: userModel != null
              ? FutureBuilder(
                  builder: (context, snapshot) {
                    if (cartController.cartObjectList.length != 0) {
                      return new FloatingActionButton.extended(
                        heroTag: "Proceed Button",
                        backgroundColor: colorScheme.secondary,
                        onPressed: () {
                          CartController.codeController.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddressPage()));
                        },
                        label: new Text(
                          " Proceed",
                        ),
                        icon: new Icon(
                          CupertinoIcons.checkmark_alt_circle_fill,
                          size: 22,
                        ),
                      );
                    } else {
                      return new Container();
                    }
                  },
                  future: cartController.fetchCart(
                      context, userModel.id, userModel.token),
                )
              : new Container(),
        ),
      ),
    );
  }
}
