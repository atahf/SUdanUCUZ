import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/design/ColorPalet.dart';
import 'package:project/design/TextStyles.dart';

//map page
class MapApp extends StatefulWidget {
  LatLng? camPosition;
  String? title;
  String? price;
  MapApp({ Key? key, this.camPosition, this.title, this.price }): super(key: key);

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: widget.camPosition ?? LatLng(40.891285,29.379905),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: widget.title ?? "YOU",
        snippet: widget.price ?? "",
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalet.appBarColor,
          title: Text(
            'Maps',
            style: appBarText,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.camPosition ?? LatLng(40.891285,29.379905),
                  zoom: 14,
                ),
                markers: markers.values.toSet(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
