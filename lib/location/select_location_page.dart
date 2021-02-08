import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzzmart/location/util/location_select_controller.dart';
import 'package:zzzmart/res/global_data.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final LocationSelectController locationController = Get.find();
  // final BestItemUtil bestItemUtil = Get.find();

  CameraPosition _initialLocation;
  GoogleMapController mapController;

  Position _currentPosition;
  String _currentAddress;

  final searchAddressController = TextEditingController();

  final searchAddressFocusNode = FocusNode();

  Set<Marker> markers = {};

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14.0,
            ),
          ),
        );
      });
      _getAddress(position.latitude, position.longitude);
      // if (markers.isNotEmpty) markers.clear();
      // markers.add(Marker(
      //   markerId: MarkerId("1"),
      //   position: LatLng(position.latitude, position.longitude),
      // ));
      // await _getAddress(position.latitude, position.longitude);
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress(lat, lng) async {
    print("LLLLLLLLL LLLLLLLL $lat $lng");
    try {
      List<Placemark> p = await placemarkFromCoordinates(lat, lng);

      Placemark place = p[0];

      setState(() {
        locationController.currentLatLng.value = new LatLng(lat, lng);
        locationController.currentPlaceMark.value = place;
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        print("CA_____$_currentPosition");
        searchAddressController.text = _currentAddress;
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("lat", "$lat");
      prefs.setString("lng", "$lng");
      // bestItemUtil.fetchItems(
      //     "${locationController.currentPlaceMark.value.administrativeArea} ${locationController.currentPlaceMark.value.postalCode}");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    if (locationController.currentLatLng != null) {
      print("GD Not Null ${locationController.currentLatLng}");
      _initialLocation = CameraPosition(
          target: LatLng(locationController.currentLatLng.value.latitude,
              locationController.currentLatLng.value.longitude),
          zoom: 12.0);
    } else {
      _initialLocation =
          CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 12.0);
      print("GD Null $_initialLocation");
    }
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new WillPopScope(
      onWillPop: () => _willPopCallback(),
      child: Container(
        height: height,
        width: width,
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              // Map View
              GoogleMap(
                markers: markers != null ? markers : null,
                initialCameraPosition: _initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapToolbarEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet(),
                onTap: (val) async {
                  setState(() {
                    _initialLocation = CameraPosition(
                        target: LatLng(val.latitude, val.longitude));
                  });
                  markers.clear();
                  markers.add(Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(val.latitude, val.longitude),
                  ));

                  await _getAddress(val.latitude, val.longitude);
                  print("LL______$_initialLocation");
                },
              ),
              // Show zoom buttons and Current Location Button
              SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 100),
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
                    ],
                  ),
                ),
              ),
              // Show the place input fields & button for
              // showing the route
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: new Row(
                          children: [
                            new CupertinoButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topLeft: Radius.circular(25)),
                              child: new Icon(CupertinoIcons.back),
                              padding: EdgeInsets.all(7),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            new Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  placesAutoCompleteTextField(),
                                ],
                              ),
                            ),
                            new CupertinoButton(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), topRight: Radius.circular(25)),
                              onPressed: () async {
                                if (_currentPosition != null) {
                                  mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          _currentPosition.latitude,
                                          _currentPosition.longitude,
                                        ),
                                        zoom: 18.0,
                                      ),
                                    ),
                                  );
                                  markers.clear();
                                  markers.add(Marker(
                                    markerId: MarkerId("1"),
                                    position: LatLng(
                                      _currentPosition.latitude,
                                      _currentPosition.longitude,
                                    ),
                                  ));
                                  await _getAddress(
                                    _currentPosition.latitude,
                                    _currentPosition.longitude,
                                  );
                                } else {
                                  _getCurrentLocation();
                                }
                              },
                              child: new Icon(Icons.my_location),
                              padding: EdgeInsets.all(7),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: new Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    Navigator.of(context).pop();
    // topStoresController.fetchTopStores(locationController.currentLatLng.value.latitude, locationController.currentLatLng.value.longitude,  GlobalData.currentRadius);
    return true; // return true if the route to be popped
  }

  placesAutoCompleteTextField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: searchAddressController,
          googleAPIKey: GlobalData.GOOGLE_API_KEY,
          inputDecoration: InputDecoration(
            hintText: "Search location here...",
            border: InputBorder.none,
          ),
          debounceTime: 800,
          countries: ["in", "fr"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) async {
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(double.parse(prediction.lat.toString()),
                      double.parse(prediction.lng.toString())),
                  zoom: 18.0,
                ),
              ),
            );
            if (markers.isNotEmpty) markers.clear();
            markers.add(Marker(
              markerId: MarkerId("1"),
              position: LatLng(double.parse(prediction.lat.toString()),
                  double.parse(prediction.lng.toString())),
            ));
            FocusScope.of(context).requestFocus(new FocusNode());
            await _getAddress(double.parse(prediction.lat.toString()),
                double.parse(prediction.lng.toString()));
          },
          itmClick: (Prediction prediction) async {
            searchAddressController.text = prediction.description;
            searchAddressController.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description.length));
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(double.parse(prediction.lat.toString()),
                      double.parse(prediction.lng.toString())),
                  zoom: 18.0,
                ),
              ),
            );
            if (markers.isNotEmpty) markers.clear();
            markers.add(Marker(
              markerId: MarkerId("1"),
              position: LatLng(double.parse(prediction.lat.toString()),
                  double.parse(prediction.lng.toString())),
            ));
            await _getAddress(double.parse(prediction.lat.toString()),
                double.parse(prediction.lng.toString()));
          }
          // default 600 ms ,
          ),
    );
  }
}
