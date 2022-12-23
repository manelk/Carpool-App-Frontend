import 'dart:convert';

import 'package:carpoolapp/models/car.dart';
import 'package:carpoolapp/config.dart';
import 'package:http/http.dart' as http;

class CarApi {
  static Future<Car> fetchCar() async {
    final response = await http.get(Uri.parse(API_URL + '/user/getCarByUser'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["CarByUser"][0]["car"]);
      return Car.fromJson(jsonResponse["CarByUser"][0]["car"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<Car> getCarById(idCar) async {
    print("idCar" + idCar);
    final response =
        await http.get(Uri.parse(API_URL + '/car/getCarById' + '/' + idCar));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = json.decode(response.body);
      print("jsonResponse!!!!!!!!!!!!");
      print(jsonResponse["CarOne"]);
      return Car.fromJson(jsonResponse["CarOne"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<Car> editCar(idCar, brand, color, energy_type) async {
    final response = await http.patch(
        Uri.parse(API_URL + '/car/editCarInformation/' + idCar),
        body: {"brand": brand, "color": color, "energy_type": energy_type});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["updateCar"]);
      return Car.fromJson(jsonResponse["updateCar"]);
      // return Car.fromJson(jsonResponse["CarByUser"][0]["car"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<Car> deleteCar(idCar) async {
    final response = await http
        .delete(Uri.parse(API_URL + '/car/deleteCarInformation/' + idCar));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = json.decode(response.body);
      print("@@@@@@@@@@2 jsonResponse");
      print(jsonResponse);
      return jsonResponse["deleteCar"];
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> postCars(
      String brand, String model, String color, String energy_type) async {
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
