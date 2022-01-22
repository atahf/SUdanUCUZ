import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:project/design/ColorPalet.dart';
import 'package:project/design/TextStyles.dart';


LatLng startLocation = const LatLng(40.891285,29.379905);

class PickLoc extends StatefulWidget{

  @override
  _PickLocState createState() => _PickLocState();
}

class _PickLocState extends State<PickLoc> {
  String googleApikey = "AIzaSyAXebm5jeIzd1tmZ6CZv9VXTwzTezPtibY";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  String location = "";
  LatLng? inputLoc;



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

  Future setLocation() async{
    await FirebaseFirestore.instance.collection("Locations").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "long": inputLoc!.longitude,
      "alt":inputLoc!.latitude
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalet.appBarColor,
          title: Text(
            "Choose Your Location",
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
                    _getLocation(inputLoc!);
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
                            child: const Text("Confirm Your Adress"),
                            onPressed: () {
                              if(location != "") {
                                setLocation();
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