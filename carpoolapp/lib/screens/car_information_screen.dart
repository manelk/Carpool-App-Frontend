import 'dart:convert';

import 'package:carpoolapp/apis/car_api.dart';
import 'package:carpoolapp/models/car.dart';
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:http/http.dart' as http;

import 'package:carpoolapp/apis/rides_api.dart';

class CarInformationScreen extends StatefulWidget {
  const CarInformationScreen({Key? key}) : super(key: key);

  @override
  State<CarInformationScreen> createState() => _CarInformationScreenState();
}

class _CarInformationScreenState extends State<CarInformationScreen> {
  late Future<Car>? futureCar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCar = CarApi.fetchCar();
    FutureBuilder<Car>(
      future: futureCar,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return Text(data.brand!);
        } else {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

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
      body: Center(
          child: FutureBuilder<Car>(
        future: futureCar,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var carInformation = snapshot.data;
            // return Text(testa!);
            return SafeArea(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'images/passengercar2.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Car Brand: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                  color: Color(0xFF008CFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                carInformation!.brand.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Car Model: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                  color: Color(0xFF008CFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                carInformation.model.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Car Color: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                  color: Color(0xFF008CFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                carInformation.energy_type.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          //By default, show a loading spinner.
          return const CircularProgressIndicator(
            value: 20,
          );
        },
      )),
    );
  }
}
