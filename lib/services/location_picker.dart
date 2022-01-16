import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:project/design/ColorPalet.dart';
import 'package:project/design/TextStyles.dart';


class PickLoc extends StatefulWidget{
  const PickLoc({Key? key}) : super(key: key);

  @override
  _PickLocState createState() => _PickLocState();
}

class _PickLocState extends State<PickLoc> {
  String googleApikey = "AIzaSyAXebm5jeIzd1tmZ6CZv9VXTwzTezPtibY";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(40.891285,29.379905);
  late LatLng inputLoc;
  String location = "";

  void _getLocation(LatLng loc) async {
    GeoCode geoCode = GeoCode();
    try {
      Address address = await geoCode.reverseGeocoding(latitude: loc.latitude, longitude: loc.longitude);
      if(address.city != null) {
        setState(() {
          location = address.streetAddress.toString() + ", "
              + address.streetNumber.toString() + ", "
              + address.city! + ", "
              + address.countryName! + ", "
              + address.postal.toString();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalet.appBarColor,
          title: Text(
            "Location Picker",
            style: appBarText,
          ),
          centerTitle: true,
        ),
        body: Stack(
            children:[
              GoogleMap(
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: startLocation,
                  zoom: 14.0,
                ),
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona;
                  setState(() {
                    inputLoc = LatLng(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                    _getLocation(inputLoc);
                  });
                },
              ),

              const Center(
                child: Icon(Icons.location_pin, size: 50, color: Colors.red),
              ),

              Positioned(
                  bottom:80,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: (location == "")? Center(): Card(
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(children: [

                          ListTile(
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            dense: true,
                          ),

                          ElevatedButton(
                            child: const Text("confirm address"),
                            onPressed: () {
                              if(location != "") {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ]),
                      ),
                    ),
                  )
              ),
            ]
        )
    );
  }
}