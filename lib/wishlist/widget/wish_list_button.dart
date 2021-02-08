import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/wishlist/util/wish_list_util.dart';

class CommonWishListButton extends StatefulWidget {
  final String productId, pQty;

  CommonWishListButton(this.productId, this.pQty);

  @override
  _CommonWishListButtonState createState() => _CommonWishListButtonState();
}

class _CommonWishListButtonState extends State<CommonWishListButton> {
  bool isLoading = false;
  bool wishListed = false;
  UserModel userModel;

  @override
  void initState() {
    userModel = CurrentUser.getCurrentUser();
    checkWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoButton(
      onPressed: () async {
        if (userModel != null) {
          String status;
          setState(() {
            isLoading = true;
          });
          if (wishListed) {
            status = await WishListController.deleteWishList(
                userModel.id, userModel.token, widget.productId);
            if (status == "true") {
              setState(() {
                WishListController.productList.clear();
              });
            }
          } else {
            status = await WishListController.addToWishList(
                userModel.id, widget.productId, widget.pQty);
          }
          await WishListController.fetchWishListItems(
              userModel.id, userModel.token);
          await checkWishList();
          setState(() {
            isLoading = false;
          });
          print("Status Wish List $status");
        } else {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Login Please!'),
              content: Text(
                  'If you want to save this item for future, Please Login to continue the further process.'),
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
      child: isLoading
          ? CupertinoActivityIndicator(
              radius: 10,
              animating: true,
            )
          : wishListed
              ? new Icon(
                  Icons.favorite_rounded,
                  color: colorScheme.primary,
                )
              : new Icon(
                  Icons.favorite_border_rounded,
                  color: colorScheme.primary,
                ),
      color: colorScheme.onPrimary,
      padding: EdgeInsets.all(0),
    );
  }

  checkWishList() async {
    if (userModel != null) {
      print("AVAILABLE DATA  ${WishListController.productList.length}");
      await WishListController.fetchWishListItems(
          userModel.id, userModel.token);
      if (WishListController.productList.length != 0) {
        for (var i = 0; i < WishListController.productList.length; i++) {
          print("ID++++++++++++++${WishListController.productList[i].pName}");
          print(
              "CCCCCC${WishListController.productList[i].pId}  ${widget.productId}");
          if (WishListController.productList[i].pId == widget.productId) {
            setState(() {
              wishListed = true;
            });
            break;
          } else {
            wishListed = false;
          }
        }
      } else {
        setState(() {
          wishListed = false;
        });
      }
      return wishListed;
    } else {
      setState(() {
        wishListed = false;
      });
    }
  }
}
