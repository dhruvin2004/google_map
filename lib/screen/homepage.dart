import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/app_string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const LatLng _kMapCenter =
  LatLng(19.018255973653343, 72.84793849278007);

  static const CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  // late GoogleMapController mapController;

  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Google Map"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  AppString.isTheme = !AppString.isTheme;
                });
              },
              icon: Icon(Icons.location_history))
        ],
      ),
      body :GoogleMap(
       initialCameraPosition: _kInitialPosition,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        mapType: (AppString.isTheme) ? MapType.satellite : MapType.normal,
        markers: {
          const Marker(
            markerId: MarkerId("My Location"),
            position: _kMapCenter,
            infoWindow: InfoWindow(title: 'My Location'),
            rotation: 90,
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () async{
            getUserCurrentLocation().then((value) async {
              print("${value.latitude} ${value.longitude}");

              // marker added for current users location
              _markers.add(
                  Marker(
                    markerId: const MarkerId("1"),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: const InfoWindow(
                      title: 'My Current Location',
                    ),
                  )
              );

              // specified current users location
              CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
              );

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {
              });
            });
          },
          child: const Icon(Icons.my_location,color: Colors.white,),
        ),
      ),

    );
  }
}