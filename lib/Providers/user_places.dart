import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:GreatMemory/Models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        location: null,
        title: pickedTitle);
    _items.add(newPlace);
    notifyListeners();
  }
}
