import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lokthienwestern/model/delivery.dart';
import 'package:ndialog/ndialog.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double screenHeight, screenWidth;
  double dis = 0;
  Set<Marker> markers = Set();
  String _address = "No location selected.";
  Delivery _delivery;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _shopPosition = CameraPosition(
    target: LatLng(5.32146, 100.45399),
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    showShopMarker();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.black,
        title: Text('Select Location',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                  flex: 7,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _shopPosition,
                    markers: markers.toSet(),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    onTap: (newLatLng) {
                      _loadAdd(newLatLng);
                    },
                  )),
              Divider(
                height: 5,
              ),
              Flexible(
                  flex: 3,
                  child: Container(
                      width: screenWidth,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text("Please select your delivery address from map",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Container(
                              width: screenWidth / 1.2,
                              child: Divider(),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 200,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            height: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(_address),
                                            )),
                                        SizedBox(height: 10),
                                        Text("Delivery distance :" +
                                            dis.toStringAsFixed(2) +
                                            "km")
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child:
                                          VerticalDivider(color: Colors.black)),
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black,
                                              ),
                                              onPressed: () {
                                                if (dis > 15) {
                                                  Fluttertoast.showToast(
                                                    msg: "Current Delivery Distance is " +
                                                        dis.toStringAsFixed(2) +
                                                        " KM. \nMaximum Delivery Distance is 15 KM. Please try again.",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                  return;
                                                }
                                                Navigator.pop(
                                                    context, _delivery);
                                              },
                                              child: Text("Save",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )))))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  void showShopMarker() {
    MarkerId markerId1 = MarkerId("13");
    markers.add(Marker(
      markerId: markerId1,
      position: LatLng(5.32146, 100.45399),
      infoWindow: InfoWindow(
        title: 'Shop Location',
        snippet: "Lok Thien Western",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void _loadAdd(LatLng newLatLng) async {
    MarkerId markerId1 = MarkerId("12");
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    List<Placemark> newPlace =
        await placemarkFromCoordinates(newLatLng.latitude, newLatLng.longitude);

    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    _address = name +
        ", " +
        subLocality +
        ", " +
        locality +
        ", " +
        postalCode +
        ", " +
        administrativeArea +
        ", " +
        country;
    markers.clear();
    markers.add(Marker(
      markerId: markerId1,
      position: LatLng(newLatLng.latitude, newLatLng.longitude),
      infoWindow: InfoWindow(
        title: 'Address',
        snippet: _address,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
    dis = calculateDistance(newLatLng.latitude, newLatLng.longitude);
    _delivery = Delivery(_address, newLatLng);
    setState(() {});
    progressDialog.dismiss();
  }

  double calculateDistance(lat1, lon1) {
    var lat2 = 5.32146;
    var lon2 = 100.45399;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
