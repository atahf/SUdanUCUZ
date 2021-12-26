import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//map page
class MapApp extends StatefulWidget {
  LatLng? camPosition;
  MapApp({ Key? key, this.camPosition }): super(key: key);

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Maps',
            style: TextStyle(
              color: Colors.amberAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan[700],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.camPosition ?? LatLng(40.891285,29.379905),
                  zoom: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
