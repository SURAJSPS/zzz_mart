import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/wishlist/model/wish_list_model.dart';
import 'package:zzzmart/wishlist/util/wish_list_util.dart';

class WishListCard extends StatefulWidget {
  final WishListModel wishListModel;

  WishListCard(
    this.wishListModel,
  );

  @override
  _WishListCardState createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  final UserModel userModel = CurrentUser.getCurrentUser();

  Future<List<dynamic>> bookmarkFuture;
  List<dynamic> list = new List();

  @override
  void initState() {
    // TODO: implement initState
    print("WishListId  ${widget.wishListModel.wishListId}");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Container(
      height: 90,
      child: new Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
        elevation: 1,
        shadowColor: colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: new Container(
          width: size.width,
          height: 90,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          color: Colors.transparent,
          child: new Row(
            children: [
              new CupertinoButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => NavigateTo(widget.wishListModel),
                  //     ));
                },
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: [
                    new SizedBox(
                      width: 100,
                      height: 80,
                      child: new ClipRRect(
                          child: new Image.network(
                            "https://zzzmart.com/assets/uploads/${widget.wishListModel.pFeaturedImage}",
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    new Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(25),
                    ),
                  ],
                ),
              ),
              new SizedBox(
                width: 10,
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      "${widget.wishListModel.pName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    new Text(
                      "${GlobalData.removeAllHtmlTags("${widget.wishListModel.pShortDesc}")}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w400),
                    ),
                    new Expanded(
                      child: new Container(),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Text(
                              "₹${double.parse(widget.wishListModel.pCurrentPrice).floor()}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                            new SizedBox(
                              width: 5,
                            ),
                            new Text(
                              "₹${double.parse(widget.wishListModel.pOldPrice).floor()}",
                              style: TextStyle(
                                  color: colorScheme.secondaryVariant,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 30,
                          child: new CupertinoButton(
                            onPressed: () async {
                              String isDeleted =
                                  await WishListController.deleteWishList(
                                      userModel.id,
                                      userModel.token,
                                      widget.wishListModel.pId);
                              print("DDDD d $isDeleted");
                              if (isDeleted == "true") {
                                WishListController.productList.clear();
                                WishListController.fetchWishListItems(
                                    userModel.id, userModel.token);
                                WishListController.showInSnackBar(
                                    "Item Removed Successfully!",
                                    context,
                                    colorScheme.secondary,
                                    colorScheme.onPrimary);
                              } else {
                                WishListController.showInSnackBar(
                                    "Failed To Remove Item!",
                                    context,
                                    Colors.black,
                                    colorScheme.onPrimary);
                              }
                            },
                            padding: EdgeInsets.all(0),
                            child: Icon(CupertinoIcons.delete),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onRefresh() async {
    // bookmarkFuture = WishListLocalController.read();
    // list = await WishListLocalController.read();
  }
}
