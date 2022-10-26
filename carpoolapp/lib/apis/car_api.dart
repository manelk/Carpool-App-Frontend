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
      return Car.fromJson(jsonResponse["CarByUser"][0]["car"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> postCars(
      String a, String b, String c, String d) async {
    print('****************');
    b = "Default Model";
    var url = 'http://10.0.2.2:3100/Api/car';
    var data = {"brand": a, "model": b, "color": c, "energy_type": d};
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var message = jsonDecode(response.body);
    print("tes $message");
  }

  static Future<List> getManufacturer() async {
    print('****************');
    var url = 'http://10.0.2.2:3100/Api/getManufacturer';
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var rep = jsonDecode(response.body);
    var CarManufacturerList = rep["CarManufacturerList"];
    //print(rep["CarManufacturerList"]);
    // print(CarManufacturerList);
    var List = [];
    for (var element in CarManufacturerList) {
      List.add(element);
    }
    // print("haja");
    // print(List);
    return List;
  }
}
