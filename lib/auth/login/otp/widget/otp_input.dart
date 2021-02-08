import 'package:flutter/material.dart';

class OtpInputField extends StatefulWidget {
  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {

  TextEditingController _currentDigit;
  TextEditingController _firstDigit;
  TextEditingController _secondDigit;
  TextEditingController _thirdDigit;
  TextEditingController _fourthDigit;

  get _getInputField {
    _currentDigit = _firstDigit;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

  // Current digit
  void _setCurrentDigit(TextEditingController c) {
    setState(() {
      _currentDigit = c;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null)
        _fourthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        // Verify your otp by here. API call
      }
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(TextEditingController digit) {
    return new Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(2),
      alignment: Alignment.center,
      child: TextFormField(
        controller: digit,
        onTap: (){
          setState(() {
            _setCurrentDigit(digit);
          });
        },
        onChanged: (val){
          if(val != null){
            setState(() {});
          }else{

          }
        },
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24,),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.grey,
          border: InputBorder.none,),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey, width: 1)),
    );
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _getInputField;
  }
}
