// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:zzzmart/auth/registration/util/register_util.dart';
//
// class ImagePickerButton extends StatefulWidget {
//   @override
//   _ImagePickerButtonState createState() => _ImagePickerButtonState();
// }
//
// class _ImagePickerButtonState extends State<ImagePickerButton> {
//   Future getImage() async {
//     final pickedFile =
//         await RegisterUtil.picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         RegisterUtil.image = File(pickedFile.path);
//         print('image selected. $pickedFile');
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return new CupertinoButton(
//       child: new Container(
//         height: 30,
//         width: 30,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: colorScheme.onSurface,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: colorScheme.onPrimary, width: 2)),
//         child: new Icon(
//           Icons.edit,
//           size: 18,
//         ),
//       ),
//       onPressed: () {
//         getImage();
//       },
//       padding: EdgeInsets.all(0),
//     );
//   }
// }
