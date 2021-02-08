// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fourcutss/main/home/util/best_item_util.dart';
// import 'package:fourcutss/src/global_data.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LocationBarPage extends StatefulWidget {
//   @override
//   _LocationBarPageState createState() => _LocationBarPageState();
// }
//
// class _LocationBarPageState extends State<LocationBarPage> {
//   var addresses;
//   Address address;
//
//   getLocation(lat, lng) async {
//     final coordinates = new Coordinates(lat, lng);
//     var address =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     setState(() {
//       addresses = address;
//       GlobalData.currentAddress = addresses;
//       GlobalData.currentLat = lat;
//       GlobalData.currentLang = lng;
//     });
//     print("LL___  ${addresses.first.featureName} : ${addresses.first.postalCode}");
//     if(Platform.isIOS){
//       String state;
//
//       if(GlobalData.currentAddress.first.adminArea == "UP"){
//         state = "Uttar Pradesh";
//       }else if(GlobalData.currentAddress.first.adminArea == "AS"){
//         state = "Assam";
//       }else if(GlobalData.currentAddress.first.adminArea == "ML"){
//         state = "Meghalaya";
//       }else{
//         state = GlobalData.currentAddress.first.adminArea;
//       }
//
//       BestItemUtil.fetchItems(
//           "$state ${GlobalData.currentAddress.first.postalCode}");
//     }else{
//       print("ZIP  ${addresses.first.postalCode}");
//       BestItemUtil.fetchItems(
//           "${GlobalData.currentAddress.first.adminArea} ${GlobalData.currentAddress.first.postalCode}");
//     }
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("lat", lat.toString());
//     prefs.setString("lng", lng.toString());
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return new GestureDetector(
//       onTap: () async {
//         LocationResult result = await showLocationPicker(
//           context, "AIzaSyC5m-C32piW2yiT3kevVbvLfHXsLsPTWik",
//           initialCenter: LatLng(31.1975844, 29.9598339),
//           automaticallyAnimateToCurrentLocation: true,
//           myLocationButtonEnabled: true,
//           layersButtonEnabled: true,
//           desiredAccuracy: LocationAccuracy.best,
//         );
//         print("result = $result");
//         getLocation(result.latLng.latitude, result.latLng.longitude);
//       },
//       child: new Container(
//         child: new Row(
//           children: [
//             new Icon(
//               Icons.location_pin,
//               color: colorScheme.primary,
//               size: 24,
//             ),
//             new SizedBox(
//               width: 5,
//             ),
//             new Expanded(child: new Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 new Text(
//                   "${GlobalData.currentAddress[0].locality}",
//                   maxLines: 1,
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: colorScheme.primary),
//                 ),
//                 new Container(
//                   child: new Text(
//                     "${GlobalData.currentAddress[0].addressLine}",
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: colorScheme.secondary),
//                   ),
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
