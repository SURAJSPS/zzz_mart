import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/address/util/address_controller.dart';
import 'package:zzzmart/address/util/address_util.dart';
import 'package:zzzmart/address/widget/add_address_page.dart';
import 'package:zzzmart/address/widget/update_address_page.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/cart/controller/cart_controller.dart';
import 'package:zzzmart/cart/payment/confirm/confirm_page.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/res/my_loader.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController landmarkController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController zipCodeController = new TextEditingController();
  BuildContext _context;

  final CartController cartController = Get.find();

  String mobilePattern =
      r"(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)";
  RegExp mobileRegExp;

  final AddressController addressPageController = Get.find();

  UserModel userModel;
  Future addressFuture;
  String selectedRadio;

  @override
  void initState() {
    mobileRegExp = new RegExp(mobilePattern);
    userModel = CurrentUser.getCurrentUser();
    addressFuture =
        AddressUtil.fetchAddress(context, userModel.id, userModel.token);
    // TODO: implement initState
    selectedRadio = addressPageController.currentAddressIndex.toString();
    super.initState();
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: CupertinoNavigationBar(
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
          "Choose Address",
          style: TextStyle(color: colorScheme.primary),
        ),
      ),
      body: new Builder(builder: (BuildContext context) {
        _context = context;
        return new Column(
          children: [
            new Container(
              width: size.width,
              child: new CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAddressPage()));
                },
                child: new Text(
                  "Add New Address",
                  style: TextStyle(color: Colors.black),
                ),
                color: colorScheme.onSurface,
              ),
              padding: EdgeInsets.all(10),
            ),
            new Expanded(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot snapshot) {
                  if (AddressUtil.status != "true" &&
                      addressPageController.addressObjectList.length == 0) {
                    return Center(
                      child: new MyLoader(),
                    );
                  } else if (AddressUtil.status == "true" &&
                      addressPageController.addressObjectList.length == 0) {
                    return Center(
                      child: new Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmWYKosWIJG36d3kjoO3KWUdNW0gPWZ6oLqw&usqp=CAU"),
                    );
                  } else {
                    return Obx(() => new ListView.builder(
                          itemCount:
                              addressPageController.addressObjectList.length,
                          padding: EdgeInsets.only(bottom: 60),
                          itemBuilder: (context, index) {
                            return new Card(
                              elevation: 1,
                              child: RadioListTile(
                                value: "$index",
                                groupValue: selectedRadio,
                                onChanged: (val) async {
                                  setSelectedRadio(val);
                                  addressPageController
                                      .currentAddressIndex.value = val;
                                  // Navigator.of(context).pop();
                                  print("__________$val");
                                },
                                title: new Container(
                                  color: Colors.transparent,
                                  width: size.width,
                                  padding: EdgeInsets.all(15),
                                  alignment: Alignment.topLeft,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      new Text(
                                        "${addressPageController.addressObjectList[index].landmark} ${addressPageController.addressObjectList[index].address}, ${addressPageController.addressObjectList[index].city}",
                                        textAlign: TextAlign.start,
                                      ),
                                      new Row(
                                        children: [
                                          new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new Text(
                                                "Zip: ${addressPageController.addressObjectList[index].zipCode}",
                                                textAlign: TextAlign.start,
                                              ),
                                              new Text(
                                                "Phone: ${addressPageController.addressObjectList[index].phone}",
                                                textAlign: TextAlign.start,
                                              )
                                            ],
                                          ),
                                          new Expanded(
                                            child: new Container(),
                                          ),
                                          new IconButton(
                                            color: Colors.blue,
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateAddressPage(
                                                              addressPageController
                                                                      .addressObjectList[
                                                                  index])));
                                            },
                                          ),
                                          new IconButton(
                                            color: Colors.black,
                                            icon: Icon(Icons.delete_forever),
                                            onPressed: () {
                                              confirmDialog(
                                                  context,
                                                  addressPageController
                                                      .addressObjectList[index]
                                                      .id);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
                  }
                },
                future: addressFuture,
              ),
            ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (_context) => FloatingActionButton.extended(
          onPressed: () {
            if (addressPageController.currentAddressIndex.value != null &&
                addressPageController.addressObjectList.length != 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPage(),
                  ));
            } else {
              GlobalData.showInSnackBar(
                  "Please choose address first!",
                  _context,
                  Colors.red,
                  Colors.white,
                  CupertinoIcons.info_circle_fill,
                  Colors.white);
            }
          },
          label: new Text("Continue"),
          icon: Icon(CupertinoIcons.arrow_right_circle_fill),
        ),
      ),
    );
  }

  confirmDialog(context, id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Warning!"),
        content: new Text("You really want to delete."),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Yes"),
            onPressed: () async {
              print("Action 2 is been clicked");
              await deleteItem(id, context);
              Navigator.pop(context);
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
      ),
    );
  }

  deleteItem(id, context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Center(
            child: MyLoader(),
          );
        });
    String status = await AddressUtil.deleteAddress(context, id);
    Navigator.of(context).pop();
    if (status == "true") {
      print("Removed");
      await AddressUtil.fetchAddress(context, userModel.id, userModel.token);
    } else {
      print("Not Deleted");
    }
  }
}
