import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/res/colors.dart';

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          backgroundColor: MyColors.yellow,
        ),
      ),
    );
  }
}
