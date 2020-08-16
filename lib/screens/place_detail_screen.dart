import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreatMemory/Providers/user_places.dart';
import 'package:GreatMemory/screens/map_screen.dart';

/// Display a screen of a place that contains various detail information
/// passing place id as argument
class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    /// get the id from argument
    final id = ModalRoute.of(context).settings.arguments;

    /// then search by id from the list inside provider
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(id);

    return Scaffold(
      /// show place title
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(
        children: <Widget>[
          /// shows picture taken
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

          /// show place address
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(height: 10),

          /// go to the Map screen
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
