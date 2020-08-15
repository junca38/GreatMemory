import 'package:GreatMemory/screens/add_place_screen.dart';
import 'package:GreatMemory/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:GreatMemory/Providers/user_places.dart';
import 'package:GreatMemory/screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => PlacesListScreen(),
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
