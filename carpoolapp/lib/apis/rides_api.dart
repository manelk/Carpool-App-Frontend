import 'dart:convert';

import 'package:carpoolapp/models/rides.dart';
import 'package:carpoolapp/config.dart';
import 'package:http/http.dart' as http;

class RidesApi {
  static Future<Rides> fetchRidesPerUser() async {
    final response = await http.get(Uri.parse(API_URL + '/ride'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonResponse = json.decode(response.body);
      // print(jsonResponse["RideList"][0]);
      // print(jsonResponse["RideList"]);
      print("element");
      List<Rides> result = [];
      jsonResponse.forEach((element) {
        print(element);
        //result.add(Rides.fromJson(element));
      });
      print("result");
      print(result);
      return Rides.fromJson(jsonResponse["RideList"][0]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
