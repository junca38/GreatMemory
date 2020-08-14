import 'package:GreatMemory/helpers/location_help.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewImgURL;

  Future<void> _getUserCurrentLocation() async {
    final locationData = await Location().getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    final mapPreviewURL = LocationHelp.generateLocationPreview(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );
    setState(() {
      _previewImgURL = mapPreviewURL;
    });
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
              ? Text('No location chosen yet.', textAlign: TextAlign.center)
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
              onPressed: null,
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
