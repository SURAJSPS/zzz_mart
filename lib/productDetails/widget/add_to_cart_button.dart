import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/home/model/product_model.dart';

class AddToCartButton extends StatefulWidget {
  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CartButton extends StatefulWidget {
  final ProductModel itemModel;

  CartButton(this.itemModel);

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  UserModel userModel;

  final CartController cartController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    userModel = CurrentUser.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    if (int.parse(widget.itemModel.pQty) < 1) {
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
      return GetX<CartController>(builder: (controller) {
        return new CupertinoButton(
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
              String status = await controller.addToCart(
                context,
                userModel.id,
                widget.itemModel.pId,
                "1",
              );
              if (status == "true") {
                print("ADDED");
                await controller.fetchCart(
                    context, userModel.id, userModel.token);
              }
              Navigator.of(context).pop();
            } else {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Login Please!'),
                  content: Text(
                      'If you want to save this item to your Cart, Please Login to continue the further process.'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false);
                      },
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            }
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
                  "  Add to Cart",
                )
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(0),
        );
      });
    }
  }
}
