import 'package:GreatMemory/Providers/user_places.dart';
import 'package:GreatMemory/screens/add_place_screen.dart';
import 'package:GreatMemory/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// main screen to show a list of locations that are stored in the system
class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Places:"),
        actions: <Widget>[
          /// go to the AppPlaceScreen to add a location
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),

      /// user future builder widget, the future is to get the list of places
      /// and the builder to display the list
      /// user can tap on an item, which will go to place_detail_screen
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<UserPlaces>(
                child: Center(child: const Text("No data yet")),

                /// check if there are data to show first
                builder: (context, userPlaces, ch) =>
                    (userPlaces.items.length <= 0)
                        ? ch
                        : ListView.builder(
                            itemCount: userPlaces.items.length,
                            itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(userPlaces.items[i].image)),
                              title: Text(userPlaces.items[i].title),
                              subtitle:
                                  Text(userPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: userPlaces.items[i].id,
                                );
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
