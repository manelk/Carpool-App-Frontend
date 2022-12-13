import 'dart:convert' as convert;

import 'package:carpoolapp/models/rides.dart';
import 'package:carpoolapp/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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

  static Future<String> getPlaceId(String input) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&sessiontoken=1234567890&key=$mapKey'));
    print("######################### ");
    //print(response);
    var json = convert.jsonDecode(response.body);
    //print(response.body);
    var placeId = json['predictions'][0]['place_id'] as String;
    //print(placeId);
    return placeId;
  }

  static Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&sessiontoken=1234567890&key=$mapKey'));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    print("@@@@@@@@@@@@@@@@");
    print(results);
    return results;
  }

  static Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$mapKey';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    print("############");
    print(json);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };
//return json;
    // print(results);
    //
    return results;
  }
}
