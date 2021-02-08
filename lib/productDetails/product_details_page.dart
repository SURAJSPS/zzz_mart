import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/cart/cart_page.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/cart/controller/local_cart.dart';
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/wishlist/widget/wish_list_button.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel productModel;

  ProductDetailsPage(this.productModel);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  UserModel userModel;
  int count = 1;
  bool availableInCart = false;
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    userModel = CurrentUser.getCurrentUser();
    checkCartQty();
    super.initState();
  }

  checkCartQty() async {
    if (userModel != null && cartController.cartObjectList.length == 0) {
      await cartController.fetchCart(context, userModel.id, userModel.token);
      for (var i = 0; i < cartController.cartObjectList.length; i++) {
        if (cartController.cartObjectList[i].pId == widget.productModel.pId) {
          setState(() {
            count = int.parse("${cartController.cartObjectList[i].pQty}");
            availableInCart = true;
          });
          break;
        }
      }
    } else if (userModel != null) {
      for (var i = 0; i < cartController.cartObjectList.length; i++) {
        if (cartController.cartObjectList[i].pId == widget.productModel.pId) {
          setState(() {
            count = int.parse("${cartController.cartObjectList[i].pQty}");
            availableInCart = true;
          });
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: colorScheme.onPrimary,
        brightness: Brightness.light,
        elevation: 1,
        title: new Text(
          "Details",
          style: TextStyle(color: colorScheme.primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.chevron_back,
            size: 32,
            color: colorScheme.primary,
          ),
        ),
        actions: [CommonWishListButton(widget.productModel.pId, "1")],
      ),
      body: new Column(
        children: [
          new Expanded(
              child: new ListView(
            children: [
              new Container(
                height: size.width * 0.5,
                width: size.width,
                color: colorScheme.onPrimary,
                child: new Image.network(
                  "https://zzzmart.com/assets/uploads/${widget.productModel.pFeaturedImage}",
                  fit: BoxFit.contain,
                ),
              ),
              // Title
              new Container(
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
                child: new Text(
                  "${widget.productModel.pName}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    color: Colors.black87,
                  ),
                ),
              ),
              new SizedBox(
                height: 5,
              ),
              // Sort Description
              new Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: new Text(
                  "${GlobalData.removeAllHtmlTags("${widget.productModel.pShortDesc}")}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Price and Share
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    new Row(
                      children: [
                        new Text(
                          "MRP: ₹${widget.productModel.pCurrentPrice}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        new SizedBox(
                          width: 5,
                        ),
                        new Text(
                          "₹${widget.productModel.pOldPrice}",
                          style: TextStyle(
                              color: colorScheme.secondaryVariant,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Icon(
                          Icons.star,
                          color: colorScheme.secondary,
                          size: 16,
                        ),
                        new Text(
                          "  (${widget.productModel.pTotalView} Views)",
                          style: TextStyle(
                              fontSize: 14, color: colorScheme.secondary),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              CommonWishListButton(widget.productModel.pId, "1"),
              int.parse(widget.productModel.pQty) < 1
                  ? new RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side:
                              BorderSide(color: colorScheme.primary, width: 2)),
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.notifications,
                        color: colorScheme.primary,
                      ),
                      label: new Text(
                        "Out of stock",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: colorScheme.primary),
                      ),
                      onPressed: null,
                    )
                  : new Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new CupertinoButton(
                            child: new Icon(
                              CupertinoIcons.minus,
                              color: count > 0
                                  ? colorScheme.onPrimary
                                  : colorScheme.secondary,
                            ),
                            onPressed: count > 1
                                ? () {
                                    if (count > 1) {
                                      setState(() {
                                        count--;
                                      });
                                    }
                                  }
                                : null,
                            padding: EdgeInsets.all(0),
                            color: colorScheme.secondary,
                          ),
                          new Container(
                            width: 50,
                            alignment: Alignment.center,
                            height: 50,
                            child: new Text(
                              "$count",
                              style: TextStyle(
                                  color: colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          new CupertinoButton(
                            child: new Icon(CupertinoIcons.plus_circle_fill),
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            padding: EdgeInsets.all(0),
                            color: colorScheme.secondary,
                          ),
                          new Spacer(),
                        ],
                      ),
                    )
            ],
          )),
          new Container(
            height: 50,
            width: size.width,
            color: colorScheme.onPrimary,
            child: new Row(
              children: [
                new Expanded(
                  child: new CupertinoButton(
                    padding: EdgeInsets.all(0),
                    color: colorScheme.secondary,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                    child: new Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Icon(
                            CupertinoIcons.cart_badge_minus,
                            size: 20,
                          ),
                          new Text("  Go To Cart")
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: getButton(context),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getButton(context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (int.parse(widget.productModel.pQty) < 1) {
      return new CupertinoButton(
        padding: EdgeInsets.all(0),
        color: Colors.black,
        onPressed: null,
        child: new Container(
          alignment: Alignment.center,
          height: 50,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Icon(
                CupertinoIcons.pencil_outline,
                size: 20,
              ),
              new Text(
                " Out of Stock",
              )
            ],
          ),
        ),
        borderRadius: BorderRadius.circular(0),
      );
    } else {
      return Builder(
        builder: (_context) => new CupertinoButton(
          padding: EdgeInsets.all(0),
          color: Colors.black,
          onPressed: () async {
            if (userModel != null) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return new Center(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    );
                  });
              String status = await cartController.addToCart(
                context,
                userModel.id,
                widget.productModel.pId,
                "$count",
              );
              if (status == "true") {
                print("ADDED");
                Navigator.of(context).pop();
                GlobalData.showInSnackBar(
                    "Successfully Added!",
                    _context,
                    colorScheme.secondary,
                    Colors.white,
                    CupertinoIcons.checkmark_seal_fill,
                    Colors.white);
                await cartController.fetchCart(
                    context, userModel.id, userModel.token);
              } else {
                Navigator.of(context).pop();
                GlobalData.showInSnackBar(
                    "Failed to Add!",
                    _context,
                    Colors.red,
                    Colors.white,
                    CupertinoIcons.info_circle_fill,
                    Colors.white);
              }
            } else {
              LocalCart.remove("${widget.productModel.pId}");
              LocalCart.save(
                  "${widget.productModel.pId}",
                  "${widget.productModel.pName}",
                  "${widget.productModel.pFeaturedImage}",
                  "${widget.productModel.pCurrentPrice}",
                  "$count");
            }
            // showCupertinoDialog(
            //   context: context,
            //   builder: (context) => CupertinoAlertDialog(
            //     title: Text('Login Please!'),
            //     content: Text(
            //         'If you want to save this item to your Cart, Please Login to continue the further process.'),
            //     actions: <Widget>[
            //       CupertinoDialogAction(
            //         child: Text('Cancel'),
            //         onPressed: () {
            //           Navigator.of(context).pop();
            //         },
            //       ),
            //       CupertinoDialogAction(
            //         child: Text('Continue'),
            //         onPressed: () {
            //           Navigator.pushAndRemoveUntil(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => LoginPage(),
            //               ),
            //               (route) => false);
            //         },
            //       ),
            //     ],
            //   ),
            //   barrierDismissible: false,
            // );
          },
          child: new Container(
            alignment: Alignment.center,
            height: 50,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Icon(
                  CupertinoIcons.bag_badge_plus,
                  size: 20,
                ),
                new Text(
                  availableInCart ? "  Update Cart" : "  Add to Cart",
                )
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(0),
        ),
      );
    }
  }
}
