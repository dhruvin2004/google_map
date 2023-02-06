

import 'package:flutter/material.dart';
import 'package:google_map/app_string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final LatLng _kMapCenter = LatLng(19.018255973653343, 72.84793849278007);

  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  late GoogleMapController _controller;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              AppString.isTheme = !AppString.isTheme;
            });
          }, icon: Icon(Icons.map))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        onMapCreated: onMapCreated,
        mapType: (AppString.isTheme)?MapType.satellite:MapType.normal,
        myLocationEnabled: true,
      ),
    );
  }

  Future onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('lib/json/map_style.json');
    _controller.setMapStyle(value);
  }
}
