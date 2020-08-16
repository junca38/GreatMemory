import 'package:flutter/foundation.dart';
import 'dart:io';

/// Place is to store id, title, PlaceLocation object, and file path to image
class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}

/// PlaceLocation is to store a location lat, long and address
class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}
