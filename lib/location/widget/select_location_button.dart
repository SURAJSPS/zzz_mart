import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzzmart/location/select_location_page.dart';
import 'package:zzzmart/location/util/location_select_controller.dart';

final LocationSelectController locationController = Get.find();

class SelectMapLocationButton extends StatefulWidget {
  final Color titleColor;
  final Color subtitleColor;

  SelectMapLocationButton(this.titleColor, this.subtitleColor);

  @override
  _SelectMapLocationButtonState createState() => _SelectMapLocationButtonState();
}

class _SelectMapLocationButtonState extends State<SelectMapLocationButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectLocationPage()));
      },
      padding: EdgeInsets.symmetric(
          horizontal: 5, vertical: 5),
      child: new Obx(() => new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text(
            locationController.currentPlaceMark.value.subAdministrativeArea != null
                ? "${locationController.currentPlaceMark.value.subAdministrativeArea} (${locationController.currentPlaceMark.value.postalCode})"
                : "Location",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: widget.titleColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          new Text(
            locationController.currentPlaceMark.value.name != null
                ? "${locationController.currentPlaceMark.value.name} ${locationController.currentPlaceMark.value.subLocality}, ${locationController.currentPlaceMark.value.administrativeArea}"
                : "Select your location",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: widget.subtitleColor,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
        ],
      )),
    );
  }
}
