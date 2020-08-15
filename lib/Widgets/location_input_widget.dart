import 'package:GreatMemory/helpers/location_help.dart';
import 'package:GreatMemory/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {
  final Function onSelectPlace;
  LocationInputWidget(this.onSelectPlace);
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewImgURL;

  void _showPreview(double lat, double long) {
    final mapPreviewURL = LocationHelp.generateLocationPreview(
      latitude: lat,
      longitude: long,
    );
    setState(() {
      _previewImgURL = mapPreviewURL;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.latitude);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (e) {
      print(e);
      return;
    }
  }

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
            FlatButton.icon(
              onPressed: _getUserCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
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
