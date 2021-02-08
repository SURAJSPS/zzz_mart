import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:zzzmart/auth/login/login_page.dart';
import 'package:zzzmart/auth/login/util/login_controller.dart';
import 'package:zzzmart/auth/registration/util/register_util.dart';
import 'package:zzzmart/navigation_page.dart';
import 'package:zzzmart/res/global_data.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: new Builder(builder: (BuildContext context) {
        _context = context;
        return new ListView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          children: [
            new SizedBox(
              height: 50,
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
                          child: RegisterUtil.image != null
                              ? Image.memory(
                                  Base64Decoder().convert(RegisterUtil.image),
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
              height: 50,
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
                placeholder: "Email Address",
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(CupertinoIcons.mail),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                controller: emailController,
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
              height: 45,
              child: new CupertinoTextField(
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                placeholder: "Password",
                maxLines: 1,
                maxLength: 15,
                obscureText: true,
                prefix: new Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(CupertinoIcons.lock_shield),
                ),
                prefixMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
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
                child: Text('Register',
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
        await RegisterUtil.picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        List<int> imageBytes = file.readAsBytesSync();
        print(imageBytes);
        RegisterUtil.image = base64Encode(imageBytes);
        print('image selected. ${RegisterUtil.image}');
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

  final LoginController loginController = Get.find();

  onRegisterClick(context) async {
    String mobilePattern =
        r"(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)";
    RegExp mobileRegExp = new RegExp(mobilePattern);

    String emailPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp emailRegExp = new RegExp(emailPattern);

    String name = nameController.value.text;
    String email = emailController.value.text.replaceAll(" ", "");
    String phone = phoneController.value.text;
    String gender = genderController.value.text;
    String password = passwordController.value.text;
    String address = addressController.value.text;
    if (name.isNotEmpty &&
        emailRegExp.hasMatch(email) &&
        password.isNotEmpty &&
        mobileRegExp.hasMatch(phone) &&
        gender.isNotEmpty &&
        address.isNotEmpty) {
      String status = await RegisterUtil.registrationUser(name,
          RegisterUtil.image, email, phone, gender, password, address, context);
      if (status == "true") {
        _btnController.success();
        String status =
            await loginController.fetchLoginUser(email, password, context);
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
      GlobalData.showInSnackBar(
          "Please Enter Correct Fields!",
          context,
          Colors.red,
          Colors.white,
          CupertinoIcons.info_circle_fill,
          Colors.white);
    }
    // it to show a SnackBar.
  }
}
