import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:labs/kolokvium.dart';

class Maps extends StatefulWidget{
  // String name;
  // String lat;
  // String lon;
  // Places place;

  List<Kolokvium> kolokviums;


  Maps(this.kolokviums);

  @override
  State<StatefulWidget> createState() => _MapsState();
}


class _MapsState extends State<Maps>{

  final Map<String, Marker> _markers = {};


  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      for (final kol in widget.kolokviums) {
        final marker = Marker(
          markerId: MarkerId(kol.name),
          position: LatLng(double.parse(kol.lat), double.parse(kol.lon)),
          infoWindow: InfoWindow(
            title: kol.place.name.toString(),
            snippet: kol.name,
          ),
        );
        _markers[kol.name] = marker;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kolokvium Location'),
          backgroundColor: Colors.blue[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.9981, 21.4254),
            zoom: 10.0,
          ),
          markers: _markers.values.toSet(),
          scrollGesturesEnabled: true,
        ),
      ),
    );
  }

}