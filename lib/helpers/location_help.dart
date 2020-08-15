import 'package:GreatMemory/helpers/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationHelp {
  static String generateLocationPreview({double latitude, double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${Constants.kAPIKey}";
  }

  static Future<String> getPlaceAddress(
      {double latitude, double longitude}) async {
    String result;
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${Constants.kAPIKey}";
    final response = await http.get(url);
    if (response != null) {
      result = jsonDecode(response.body)['results'][0]['formatted_address'];
    }
    return result;
  }
}
