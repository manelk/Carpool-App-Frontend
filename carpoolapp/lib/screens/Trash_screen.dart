import 'dart:convert';

import 'package:carpoolapp/models/car.dart';
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:http/http.dart' as http;

class CarInformationScreen extends StatefulWidget {
  const CarInformationScreen({Key? key}) : super(key: key);

  @override
  State<CarInformationScreen> createState() => _CarInformationScreenState();
}

class _CarInformationScreenState extends State<CarInformationScreen> {
  @override
  void initState() {
    late Future<Car> futureCar;
    // TODO: implement initState
    super.initState();
    futureCar = fetchCar();

    // print("whatever");
    // var x = getCarInformation().then((value) => {
    //       for (var element in value) {print(element["_id"])}
    //     });
  }

  List<String> litems = ["1", "2", "Third", "4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My car information',
          style: TextStyle(color: Color(0xFF008CFF)),
        ),
        backgroundColor: Color(0xFFF8F8F8),
        automaticallyImplyLeading: false,
        actions: [],
        elevation: 2,
      ),
      body: new ListView.builder(
          itemCount: litems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Text(litems[index]);
          }),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: GestureDetector(
      //       onTap: () => FocusScope.of(context).unfocus(),
      //       child: Padding(
      //         padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.max,
      //           children: [
      //             Row(
      //               mainAxisSize: MainAxisSize.max,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Expanded(
      //                   child: Image.asset(
      //                     'images/passengercar2.png',
      //                     width: 150,
      //                     height: 150,
      //                     fit: BoxFit.contain,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(20),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'Car Brand:',
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                       fontFamily: 'DM Sans',
      //                       color: Color(0xFF008CFF),
      //                       fontWeight: FontWeight.w500,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(20),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'Car Model:',
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                       fontFamily: 'DM Sans',
      //                       color: Color(0xFF008CFF),
      //                       fontWeight: FontWeight.w500,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(20),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'Car Color:',
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                       fontFamily: 'DM Sans',
      //                       color: Color(0xFF008CFF),
      //                       fontWeight: FontWeight.w500,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),

      //             //  FutureBuilder(future: getCarInformation(), builder: (context, (context, snapshot) => ),)
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Future<Car> fetchCar() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3100/Api/user/getCarByUser'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Car.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List> getCarInformation() async {
    print('****************');
    var url = 'http://10.0.2.2:3100/Api/user/getCarByUser';
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    // Map<String, dynamic> carMap = jsonDecode(response.body);
    // var car = Car.fromJson(carMap["CarByUser"]);
    // print('Howdy, ${car.color}!');

    var data = jsonDecode(response.body);
    print("data");
    var CarInformation = data["CarByUser"];
    //print(CarInformation);
    //print("type is ${CarInformation.runtimeType}");
    // (jsonDecode(CarInformation) as List)
    //     .map((e) => e as Map<String, dynamic>)
    //     .toList();
    // print("type is ${CarInformation.runtimeType}");
    // CarInformation.forEach((key, value) {
    //   print(key);
    // });
    //print(rep["CarManufacturerList"]);
    // print(CarManufacturerList);
    // var List = [];
    // for (var element in CarInformation {
    //   List.add(element);
    // }
    //print("haja");
    //print(List);
    return CarInformation;
  }
}
