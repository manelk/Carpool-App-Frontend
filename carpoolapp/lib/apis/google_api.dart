import 'dart:convert';

import 'package:carpoolapp/models/rides.dart';
import 'package:carpoolapp/config.dart';
import 'package:http/http.dart' as http;

// ignore: slash_for_doc_comments
/**
 * Find Place API parameters
 * 1. Place Name: my input 
 * 2. Session Token
 * 3. Map Key from Google API
 */
class GoogleApi {
  static void findPlace(String placeName) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&sessiontoken=1234567890&key=$mapKey'));
    if (response == "failed") {
      return;
    }
    print("Places prediction response:: ");
    print("Places prediction response:: ");
    print(response);
  }
}
