import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyOtpButton extends StatefulWidget {
  final VoidCallback onVerifyOtpTap;

  VerifyOtpButton(this.onVerifyOtpTap);

  @override
  _VerifyOtpButtonState createState() => _VerifyOtpButtonState();
}

class _VerifyOtpButtonState extends State<VerifyOtpButton> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      child: CupertinoButton(
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {
          widget.onVerifyOtpTap();
        },
        padding: EdgeInsets.all(0.0),
        child: Text(
          "Verify",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
