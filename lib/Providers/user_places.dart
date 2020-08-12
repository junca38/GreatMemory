import 'package:flutter/foundation.dart';
import 'package:GreatMemory/Models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
}
