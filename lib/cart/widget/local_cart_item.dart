import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/cart/controller/local_cart.dart';
import 'package:zzzmart/cart/model/local_cart_model.dart';

class LocalCartItem extends StatefulWidget {
  final LocalCartModel cartModel;
  LocalCartItem(this.cartModel);
  @override
  _LocalCartItemState createState() => _LocalCartItemState();
}

class _LocalCartItemState extends State<LocalCartItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return new Card(
      elevation: 1,
      child: new Container(
        height: 120,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: new Row(
          children: <Widget>[
            new Expanded(
                flex: 8,
                child: new Stack(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
//                  Image Area
                        new Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: 120,
                          height: 90,
                          color: Colors.transparent,
                          child: new ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.network(
                              "https://zzzmart.com/assets/uploads/${widget.cartModel.pFeaturedImage}",
                              fit: BoxFit.cover,
                              height: 90,
                              width: 120,
                            ),
                          ),
                        ),
//                  Text Area
                        new Expanded(
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "${widget.cartModel.pName}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: new TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                new SizedBox(
                                  height: 4,
                                ),
                                new Text(
                                  "MRP: ₹${(widget.cartModel.cCurrentPrice)}",
                                  style: TextStyle(
                                      color: colorScheme.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Builder(
                                  builder: (_context) => new Container(
                                    alignment: Alignment.centerRight,
                                    child: new Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      alignment: Alignment.centerRight,
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: new CupertinoButton(
                                              child: new Icon(
                                                CupertinoIcons.minus,
                                                color: colorScheme.onPrimary,
                                                size: 18,
                                              ),
                                              onPressed: null,
                                              padding: EdgeInsets.all(0),
                                              color: colorScheme.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          new Container(
                                            width: 30,
                                            alignment: Alignment.center,
                                            height: 50,
                                            child: new Text(
                                              "${widget.cartModel.pQty}",
                                              style: TextStyle(
                                                  color: colorScheme.secondary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          new SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: new CupertinoButton(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: new Icon(
                                                CupertinoIcons
                                                    .add_circled_solid,
                                                color: colorScheme.onPrimary,
                                                size: 18,
                                              ),
                                              onPressed: null,
                                              padding: EdgeInsets.all(0),
                                              color: colorScheme.secondary,
                                            ),
                                          ),
                                          new Spacer(),
                                          new SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: new CupertinoButton(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: new Icon(
                                                CupertinoIcons.delete,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              onPressed: () async {
                                                confirmDialog(context, _context,
                                                    widget.cartModel.pId);
                                              },
                                              padding: EdgeInsets.all(0),
                                              color: colorScheme.onSurface,
                                            ),
                                          ),
                                          new SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  confirmDialog(context, _context, cId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Text(
                "Alert!",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              content: new Text("You really want to delete."),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Yes"),
                  onPressed: () async {
                    print("Action 2 is been clicked");
                    Navigator.pop(context);
                    LocalCart.remove("$cId");
                    LocalCart.read();
                    // await deleteItem(cId, context, _context);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
