import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:GreatMemory/Models/place.dart';

/// show a google map on a separate screen for user to choose the desire location
class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelected;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.4220, longitude: -122.0842),
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

            /// show an icon to confirm when user had picked a location on map
            IconButton(
                icon: Icon(Icons.check),
                onPressed: _pickedlocation == null
                    ? null
                    : () {
                        /// pop back to previous screen with location data
                        Navigator.of(context).pop(_pickedlocation);
                      }),
        ],
      ),

      /// show the google map widget
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),

        /// disable the confirm function when user had not select a location
        onTap: widget.isSelected ? _selectLocation : null,

        /// update the marker when user has selected a location
        markers: (_pickedlocation == null && widget.isSelected)
            ? null
            : {
                Marker(
                  markerId: MarkerId('here'),
                  position: _pickedlocation ??
                      LatLng(widget.initialLocation.latitude,
                          widget.initialLocation.longitude),
                )
              },
      ),
    );
  }
}
