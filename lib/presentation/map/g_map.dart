import 'dart:async';

import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/theming/theme.dart';
import 'package:grad/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  static const String routeName = 'gmap';
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng src = LatLng(30, 31);

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: src,
            zoom: 10,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.mainColor)),
                onPressed: () {
                  CartScreen.cartList.clear();

                  Navigator.pop(context);
                  Alert.showAlert(context, "assets/animations/order.json",
                      "Order Was Placed Successfully");
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Save And Order",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
              FloatingActionButton(
                backgroundColor: MyTheme.mainColor,
                onPressed: () {
                  getUserCurrentLocation().then((value) {
                    print(
                        "latitude ${value.latitude.toString()} and longitude is ${value.longitude.toString()}");
                    markers.add(Marker(
                        markerId: const MarkerId("2"),
                        position: LatLng(value.latitude, value.longitude),
                        infoWindow:
                            const InfoWindow(title: "My current location")));
                    CameraPosition camPosition = CameraPosition(
                        zoom: 15,
                        target: LatLng(value.latitude, value.longitude));
                    navigateToCurrentLocation(camPosition);
                    setState(() {});
                  });
                },
                child: const Icon(Icons.my_location),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error ${error.toString()}");
    });
    return Geolocator.getCurrentPosition();
  }

  Future<void> navigateToCurrentLocation(CameraPosition camPosition) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(camPosition));
  }
}
