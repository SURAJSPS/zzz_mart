import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/auth/update/util/update_util.dart';
import 'package:zzzmart/navigation_page.dart';

class UpdatePage extends StatefulWidget {
  final UserModel userModel;

  UpdatePage(this.userModel);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  BuildContext _context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = "${widget.userModel.name}";
    phoneController.text = "${widget.userModel.phone}";
    genderController.text = "${widget.userModel.gender}";
    addressController.text = "${widget.userModel.address}";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: colorScheme.onPrimary,
        brightness: Brightness.light,
        elevation: 1,
        title: new Text(
          "Update Profile",
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
      ),
      body: new Builder(builder: (BuildContext context) {
        _context = context;
        return new ListView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          children: [
            new SizedBox(
              height: 25,
            ),
            new Container(
              alignment: Alignment.center,
              width: size.width,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border:
                            Border.all(color: colorScheme.onSurface, width: 5),
                        color: colorScheme.onSurface),
                    child: new Stack(
                      children: [
                        new ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: UpdateUtil.image != null
                              ? Image.memory(
                                  Base64Decoder().convert(UpdateUtil.image),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        new Container(
                          height: 120,
                          width: 120,
                          color: Colors.transparent,
                          alignment: Alignment.bottomRight,
                          child: getImagePickerButton(context),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            new SizedBox(
              height: 25,
            ),
            new SizedBox(
              height: 50,
              child: new CupertinoTextField(
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                placeholder: "Full Name",
                maxLines: 1,
                keyboardType: TextInputType.name,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(CupertinoIcons.person_circle),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                controller: nameController,
              ),
            ),
            new SizedBox(
              height: 25,
            ),
            new SizedBox(
              height: 50,
              child: new CupertinoTextField(
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                placeholder: "Mobile No.",
                maxLines: 1,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(CupertinoIcons.phone_circle),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.phone,
                controller: phoneController,
                maxLength: 10,
              ),
            ),
            new SizedBox(
              height: 25,
            ),
            new SizedBox(
              height: 50,
              child: new CupertinoTextField(
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                placeholder: "Gender",
                maxLines: 1,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(CupertinoIcons.person_2),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.name,
                controller: genderController,
              ),
            ),
            new SizedBox(
              height: 25,
            ),
            new SizedBox(
              height: 50,
              child: new CupertinoTextField(
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                placeholder: "Address",
                maxLines: 1,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(Icons.home_work_outlined),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
              ),
            ),
            new SizedBox(
              height: 35,
            ),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: RoundedLoadingButton(
                color: colorScheme.secondary,
                child: Text('Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900)),
                controller: _btnController,
                onPressed: () {
                  onRegisterClick(context);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Future getImage() async {
    final pickedFile =
        await UpdateUtil.picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        List<int> imageBytes = file.readAsBytesSync();
        print(imageBytes);
        UpdateUtil.image = base64Encode(imageBytes);
        print('image selected. ${UpdateUtil.image}');
      } else {
        print('No image selected.');
      }
    });
  }

  Widget getImagePickerButton(context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoButton(
      child: new Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colorScheme.onSurface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colorScheme.onPrimary, width: 2)),
        child: new Icon(
          Icons.edit,
          size: 18,
        ),
      ),
      onPressed: () {
        getImage();
      },
      padding: EdgeInsets.all(0),
    );
  }

  onRegisterClick(context) async {
    String mobilePattern =
        r"(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)";
    RegExp mobileRegExp = new RegExp(mobilePattern);

    String name = nameController.value.text;
    String phone = phoneController.value.text;
    String gender = genderController.value.text;
    String address = addressController.value.text;
    if (name.isNotEmpty &&
        mobileRegExp.hasMatch(phone) &&
        gender.isNotEmpty &&
        address.isNotEmpty) {
      String status = await UpdateUtil.updateUser(widget.userModel.id,
          widget.userModel.token, name, phone, gender, address, context);
      if (status == "true") {
        _btnController.success();
        String status = await UpdateUtil.fetchUpdatedUser(
            widget.userModel.id, widget.userModel.token, context);
        if (status == "true") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationPage()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        }
      } else {
        _btnController.error();
        Timer(Duration(seconds: 2), () {
          _btnController.error();
        });
        Timer(Duration(seconds: 4), () {
          _btnController.reset();
        });
      }
    } else {
      _btnController.reset();
      Scaffold.of(context).showSnackBar(new SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: new Text("Please Enter Correct Field!")));
    }
    // it to show a SnackBar.
  }
}
