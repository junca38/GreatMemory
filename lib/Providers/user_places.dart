import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:GreatMemory/Models/place.dart';
import 'package:GreatMemory/helpers/db_helper.dart';
import 'package:GreatMemory/helpers/location_help.dart';

class UserPlaces with ChangeNotifier {
  static const String ktableName = 'user_places';
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final String addr = await LocationHelp.getPlaceAddress(
        latitude: pickedLocation.latitude, longitude: pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: addr,
    );

    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        location: updatedLocation,
        title: pickedTitle);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      ktableName,
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        "loc_lat": newPlace.location.latitude,
        "loc_long": newPlace.location.longitude,
        "address": newPlace.location.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(ktableName);
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_long'],
                address: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
