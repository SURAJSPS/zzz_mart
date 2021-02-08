import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/home/model/store_model.dart';
import 'package:zzzmart/store/util/store_controller.dart';
import 'package:zzzmart/store/widget/all_products_view.dart';

class StoreDetailsPage extends StatefulWidget {
  final StoreModel storeModel;
  final String storeId;

  StoreDetailsPage(this.storeModel, this.storeId);

  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  final StoreController storeController = Get.find();
  var bottom;
  UserModel userModel;

  @override
  void initState() {
    userModel = CurrentUser.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return  new Scaffold(
      appBar: CupertinoNavigationBar(
        brightness: Brightness.light,
        middle: new Text(
          "Store Details",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black87),
        ),
        leading: new CupertinoButton(
          padding: EdgeInsets.all(0),
          child: new Icon(
            CupertinoIcons.arrow_left_circle_fill,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: new SafeArea(
        top: false,
        child: new ListView(
          padding: EdgeInsets.all(0),
          physics: ClampingScrollPhysics(),
          children: [
            buildProductImagesWidgets(widget.storeModel.storeBanner,
                widget.storeModel.storeName, widget.storeModel.storeDesc),
            new Card(
              margin: EdgeInsets.all(0),
              elevation: 0,
              color: colorScheme.onSurface,
              child: new Container(
                padding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: size.width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Row(
                      children: [
                        new Icon(
                          CupertinoIcons.location,
                          size: 18,
                        ),
                        new SizedBox(
                          width: 10,
                        ),
                        new Expanded(
                          child: new Text(
                            "${widget.storeModel.storeAddress}",
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
                        )
                      ],
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Row(
                      children: [
                        new Icon(
                          CupertinoIcons.phone,
                          size: 16,
                        ),
                        new SizedBox(
                          width: 10,
                        ),
                        new Expanded(
                          child: new Text(
                            "+91-${widget.storeModel.storePhone}",
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
                        )
                      ],
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Row(
                      children: [
                        new Icon(
                          CupertinoIcons.mail,
                          size: 16,
                        ),
                        new SizedBox(
                          width: 10,
                        ),
                        new Expanded(
                          child: new Text(
                            "contact.seller@email.com",
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              color: colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                'All Products',
                style: TextStyle(
                  fontSize: 18,
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
            ),
            new Card(
              color: colorScheme.onSurface,
              elevation: 0,
              margin: EdgeInsets.all(0),
              child: AllProductsView(widget.storeModel.id),
            ),
          ],
        ),
      ),
    );
  }

  buildProductImagesWidgets(banner, name, desc) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: new Stack(
        children: [
          Container(
            height: size.width * 0.4,
            width: size.width,
            color: colorScheme.onSurface,
            child: new Stack(
              children: [
                new Container(
                  height: size.width * 0.4,
                  width: size.width,
                  color: colorScheme.onSurface,
                  child: Image.network(
                    "https://zzzmart.com/assets/uploads/$banner",
                    fit: BoxFit.cover,
                  ),
                ),
                new Container(
                  height: size.width * 0.4,
                  width: size.width,
                  color: Colors.black38,
                ),
              ],
            ),
          ),
          Container(
              height: size.width * 0.6,
              width: size.width,
              color: Colors.transparent,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: size.width * 0.2, bottom: size.width * 0.05),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: colorScheme.onSurface,
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 5,
                            style: BorderStyle.solid),
                        image: DecorationImage(
                            image: NetworkImage("https://zzzmart.com/assets/uploads/$banner"), fit: BoxFit.cover)),
                  ),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new SizedBox(
                          height: 10,
                        ),
                        new Text(
                          "$name",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary),
                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        new Text(
                          "$desc",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, color: colorScheme.onPrimary),
                        ),
                        new Expanded(
                          child: new Container(),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Container(
            height: size.width * 0.6,
            width: size.width,
            color: Colors.transparent,
            alignment: Alignment.bottomRight,
            child: new Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new CupertinoButton(
                    child: new Text(
                      "Contact Seller",
                      style: TextStyle(
                        fontSize: 14,
                          color: colorScheme.primary),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    color: colorScheme.onSurface,
                    onPressed: () {
                      launch(
                          "tel:+91 ${widget.storeModel.storePhone}");
                    },
                  )
                  // getDataButtons(FontAwesomeIcons.thumbsUp, "124 Likes"),
                  // getDataButtons(FontAwesomeIcons.star, "4.3 Rating"),
                  // getDataButtons(FontAwesomeIcons.receipt, "12 Reviews"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getDataButtons(IconData icon, text) {
    return new Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: new Column(
        children: [
          new Icon(
            icon,
            size: 20,
          ),
          new SizedBox(
            height: 5,
          ),
          new Text(
            "$text",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
