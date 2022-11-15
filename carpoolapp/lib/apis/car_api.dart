import 'dart:convert';

import 'package:carpoolapp/models/car.dart';
import 'package:carpoolapp/config.dart';
import 'package:http/http.dart' as http;

class CarApi {
  static Future<Car> fetchCar() async {
    final response = await http.get(Uri.parse(API_URL + '/user/getCarByUser'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["CarByUser"][0]["car"]);
      return Car.fromJson(jsonResponse["CarByUser"][0]["car"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> postCars(
      String brand, String model, String color, String energy_type) async {
    print('****************');
    model = "Default Model";
    var data = {
      "brand": brand,
      "model": model,
      "color": color,
      "energy_type": energy_type
    };
    var response = await http.post(
      API_URL + '/car',
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var message = jsonDecode(response.body);
    print("message");
    print(message);
  }

  static Future<List> getManufacturer() async {
    print('****************');
    var response = await http.get(
      API_URL + '/getManufacturer',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var rep = jsonDecode(response.body);
    var CarManufacturerList = rep["CarManufacturerList"];
    var List = [];
    for (var element in CarManufacturerList) {
      List.add(element);
    }
    return List;
  }
}
