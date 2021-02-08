
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectController extends GetxController {
  // var roleModelList = new List<RoleModel>().obs;
  // var status = false.obs;

  var currentPlaceMark = new Placemark().obs;

  var currentLatLng = new LatLng(20.5937, 78.9629).obs;

}
