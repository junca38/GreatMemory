# GreatMemory

Simple app that user can take pictures and store location information

## Demo

https://youtu.be/izeFybIHo1g

## How to use:

- require google's GCP apikey in location_help.dart
- In android/app/src/main/AndroidManifest.xml, add keys
  - https://pub.dev/packages/google_maps_flutter

## Tech highlight:

1. Image picker package
   - To handle camera functionality
1. Path and Path Provider packages
   - To handle file path and extension inside the system
1. Location package
   - To get system location and related information
1. Google Map package
   - widget to dynamically generate google map
1. SQFLITE
   - local database to store location information and path to the image
