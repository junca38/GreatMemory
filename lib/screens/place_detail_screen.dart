import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreatMemory/Providers/user_places.dart';
import 'package:GreatMemory/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelected: false,
                  ),
                ),
              );
            },
            child: Text('view on map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
