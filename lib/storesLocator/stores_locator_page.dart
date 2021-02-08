import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zzzmart/storesLocator/model/stores_locator_model.dart';
import 'package:zzzmart/storesLocator/util/store_locator_util.dart';

class StoresLocatorPage extends StatefulWidget {
  @override
  _StoresLocatorPageState createState() => _StoresLocatorPageState();
}

class _StoresLocatorPageState extends State<StoresLocatorPage> {
  BitmapDescriptor customIcon;
  CameraPosition _initialLocation;
  GoogleMapController mapController;

  Position _currentPosition;
  String _currentAddress;

  final searchAddressController = TextEditingController();

  final searchAddressFocusNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method for retrieving the current location
  _getCurrentLocation() async {
    print("CL____________$_currentPosition");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 12.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress(lat, lng) async {
    // exploreController.currentLatLng.value = LatLng(lat, lng);
    // exploreController.fetchExploreStores(
    //     exploreController.currentLatLng.value.latitude,
    //     exploreController.currentLatLng.value.longitude,
    //     GlobalData.currentRadius);
    // try {
    //   List<Placemark> p = await placemarkFromCoordinates(lat, lng);
    //
    //   Placemark place = p[0];
    //
    //   setState(() {
    //     _currentAddress =
    //         "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
    //     print("CA_____$_currentPosition");
    //     searchAddressController.text = _currentAddress;
    //   });
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(12, 12)), 'assets/marker.png')
        .then((d) {
      customIcon = d;
    });
    _initialLocation =
        CameraPosition(target: LatLng(26.8959744, 80.9566208), zoom: 12.0);
    _getCurrentLocation();
    markerCreate();
  }

  markerCreate() async {
    List<StoreLocatorModel> listStores = await StoreLocatorUtil.fetchProducts();
    print("++++++++++++++ ${listStores.length}");
    StoreLocatorUtil.markers.clear();
    for (var i = 0; i < listStores.length; i++) {
      final MarkerId markerId = MarkerId("$i");
      print("++++++++++++++ ${listStores.length}");
      final Marker marker = Marker(
          markerId: markerId,
          position: new LatLng(double.parse(listStores[i].latitude),
              double.parse(listStores[i].longitude)),
          icon: customIcon,
          visible: true,
          infoWindow: InfoWindow(
            title: "${listStores[i].storeName}",
            snippet: "${listStores[i].storeAddress}",
            onTap: () {
              // var bottomSheetController =
              //     Scaffold.of(_scaffoldKey.currentContext)
              //         .showBottomSheet((context) => Container(
              //               child: getBottomSheet(listStores[i]),
              //               height: 250,
              //               color: Colors.transparent,
              //             ));
              print("On Tap ${listStores[i].storeName}");
            },
          ));
      setState(() {
        StoreLocatorUtil.markers.add(marker);
      });
    }
    print("Marker Length ${StoreLocatorUtil.markers.length}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: size.height,
      width: size.width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            // Map View
            GoogleMap(
              markers: StoreLocatorUtil.markers != null
                  ? StoreLocatorUtil.markers
                  : null,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: true,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                new Factory<OneSequenceGestureRecognizer>(
                  () => new EagerGestureRecognizer(),
                ),
              ].toSet(),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onTap: (val) async {},
            ),
            // Show zoom buttons and Current Location Button
            SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new CupertinoButton(
                      color: colorScheme.onSurface,
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        mapController.animateCamera(
                          CameraUpdate.zoomIn(),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 20),
                    new CupertinoButton(
                      color: colorScheme.onSurface,
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        mapController.animateCamera(
                          CameraUpdate.zoomOut(),
                        );
                      },
                      child: Icon(
                        Icons.remove,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 30),
                    new CupertinoButton(
                      onPressed: () async {
                        await _getCurrentLocation();
                        await _getAddress(
                          _currentPosition.latitude,
                          _currentPosition.longitude,
                        );
                      },
                      child: new Icon(Icons.my_location),
                      padding: EdgeInsets.all(7),
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            // Show the place input fields & button for
            // showing the route
          ],
        ),
      ),
    );
  }

  // Widget getBottomSheet(StoreLocatorModel storeLocatorModel) {
  //   return Stack(
  //     children: [
  //       Container(
  //         margin: EdgeInsets.only(top: 0),
  //         color: Colors.white,
  //         child: Column(
  //           children: [
  //             Container(
  //               color: Colors.blueAccent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "${storeLocatorModel.storeName}",
  //                       style: TextStyle(color: Colors.white, fontSize: 14),
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Text("4.5",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 12)),
  //                         Icon(
  //                           Icons.star,
  //                           color: Colors.yellow,
  //                         ),
  //                         SizedBox(
  //                           width: 20,
  //                         ),
  //                         Text("970 Folowers",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 14))
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text("${storeLocatorModel.storeAddress}",
  //                         style: TextStyle(color: Colors.white, fontSize: 14)),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Align(
  //           alignment: Alignment.topRight,
  //           child: FloatingActionButton(
  //               child: Icon(Icons.navigation), onPressed: () {}),
  //         ),
  //       )
  //     ],
  //   );
  // }
}
