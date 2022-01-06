import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLoc extends StatefulWidget {
  const PickLoc({Key? key}) : super(key: key);

  @override
  _PickLocState createState() => _PickLocState();
}

class _PickLocState extends State<PickLoc> {
  PickResult? pickLoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PickLoc"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return PlacePicker(
                            apiKey: "AIzaSyAXebm5jeIzd1tmZ6CZv9VXTwzTezPtibY",
                            hintText: "find a place ...",
                            searchingText: "Please wait ...",
                            selectText: "select place",
                            outsideOfPickAreaText: "place not in area",
                            initialPosition: LatLng(40.891285,29.379905),
                            useCurrentLocation: true,
                            selectInitialPosition: true,
                            usePinPointingSearch: true,
                            usePlaceDetailSearch: true,
                            onPlacePicked: (result) {
                              Navigator.pop(context);
                              setState(() {
                                pickLoc = result;
                              });
                            },
                          );
                        }
                    )
                  );
                },
                child: const Text("Load google map"),
            ),

            Container(
              child: Text(pickLoc?.formattedAddress ?? "error"),
            ),
          ],
        ),
      ),
    );
  }
}
