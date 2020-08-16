import 'package:GreatMemory/helpers/location_help.dart';
import 'package:GreatMemory/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/// widget to handle google map and it's function from add_place_screen.dart
/// we can either select current location to save
/// or we go to map_screen.dart to select location on google map
/// then, we will get a preview of google map
class LocationInputWidget extends StatefulWidget {
  final Function onSelectPlace;
  LocationInputWidget(this.onSelectPlace);
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewImgURL;

  /// show a preview of the location on google map
  void _showPreview(double lat, double long) {
    final mapPreviewURL = LocationHelp.generateLocationPreview(
      latitude: lat,
      longitude: long,
    );
    setState(() {
      _previewImgURL = mapPreviewURL;
    });
  }

  /// get user's current location, can call _showPreview to have a preview
  Future<void> _getUserCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.longitude);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (e) {
      print(e);
      return;
    }
  }

  /// go to MapScreen, and wait for the return location on map
  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MapScreen(
        isSelected: true,
      ),
    ));

    /// check for null error
    if (selectedLocation == null) return;

    /// update the preview and then
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),

          /// to show a preview on the selected location
          child: (_previewImgURL == null)
              ? Text('No location chosen yet', textAlign: TextAlign.center)
              : Image.network(
                  _previewImgURL,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// buttons to set current location as desired one to save
            FlatButton.icon(
              onPressed: _getUserCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),

            /// or go to google map to choose
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
