import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:labs/kolokvium.dart';

class Maps extends StatefulWidget{
  String name;
  String lat;
  String lon;
  Places place;


  Maps(this.name, this.lat, this.lon, this.place);

  @override
  State<StatefulWidget> createState() => _MapsState();
}


class _MapsState extends State<Maps>{

  final Map<String, Marker> _markers = {};


  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
        final marker = Marker(
          markerId: MarkerId(widget.name),
          position: LatLng(double.parse(widget.lat), double.parse(widget.lon)),
          infoWindow: InfoWindow(
            title: widget.place.name.toString(),
            snippet: widget.name,
          ),
        );
        _markers[widget.name] = marker;
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
          initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(widget.lat), double.parse(widget.lon)),
            zoom: 15.0,
          ),
          markers: _markers.values.toSet(),
          scrollGesturesEnabled: true,
        ),
      ),
    );
  }

}