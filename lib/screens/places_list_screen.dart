import 'package:GreatMemory/Providers/user_places.dart';
import 'package:GreatMemory/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Places:"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<UserPlaces>(
                    child: Center(child: const Text("No data yet")),
                    builder: (context, userPlaces, ch) =>
                        userPlaces.items.length <= 0
                            ? ch
                            : ListView.builder(
                                itemCount: userPlaces.items.length,
                                itemBuilder: (context, i) => ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(userPlaces.items[i].image)),
                                  title: Text(userPlaces.items[i].title),
                                  onTap: null,
                                ),
                              ),
                  ),
      ),
    );
  }
}
