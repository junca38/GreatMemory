import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:GreatMemory/Models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelected;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 26.357891, longitude: 127.7815913),
      this.isSelected = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedlocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedlocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          if (widget.isSelected)
            IconButton(
                icon: Icon(Icons.check),
                onPressed: _pickedlocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedlocation);
                      }),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelected ? _selectLocation : null,
        markers: _pickedlocation == null
            ? null
            : {Marker(markerId: MarkerId('here'), position: _pickedlocation)},
      ),
    );
  }
}
