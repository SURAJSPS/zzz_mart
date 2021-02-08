import 'package:flutter/material.dart';

class ResendOtpButton extends StatefulWidget {
  final VoidCallback onResendOtpTap;


  ResendOtpButton(this.onResendOtpTap);

  @override
  _ResendOtpButtonState createState() => _ResendOtpButtonState();
}

class _ResendOtpButtonState extends State<ResendOtpButton> {
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: () {widget.onResendOtpTap();},
      child: new Text("Resend", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),),
      color: Colors.white,
      elevation: 0,
    );
  }
}
