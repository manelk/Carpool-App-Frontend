// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:carpoolapp/apis/car_api.dart';
import 'package:carpoolapp/models/car.dart';
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/add_car_screen.dart';
import 'package:carpoolapp/screens/edit_car_information.dart';
import 'package:get/get.dart';

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
    // ignore: todo
    // TODO: implement initState
    super.initState();
    futureCar = CarApi.fetchCar();
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
        backgroundColor: const Color(0xFFF8F8F8),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: Center(
          child: FutureBuilder<Car>(
        future: futureCar,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var carInformation = snapshot.data;
            List<String> carList = [];
            String brand = carInformation!.brand.toString();
            String model = carInformation.model.toString();
            String color = carInformation.color.toString();
            String energy_type = carInformation.energy_type.toString();
            carList.add(brand);
            carList.add(model);
            carList.add(color);
            carList.add(energy_type);
            return SafeArea(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
                              // ignore: prefer_const_constructors
                              Text(
                                'Car Brand: ',
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                  color: Color(0xFF008CFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                carInformation.brand.toString(),
                                // ignore: prefer_const_constructors
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
                              // ignore: prefer_const_constructors
                              Text(
                                'Car energy type: ',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                  color: Color(0xFF008CFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                carInformation.energy_type.toString(),
                                style: const TextStyle(
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
                              const Text(
                                'Car Color: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'DM Sans',
                                  color: Color(0xFF008CFF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                carInformation.color.toString(),
                                // ignore: prefer_const_constructors
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /** Edit car */
                              GestureDetector(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // print(carInformation.id.toString());
                                    Get.off(() => EditCarScreen(
                                        id: carInformation.id.toString()));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => EditCarScreen(
                                    //       carDetails: carList,
                                    //     ),
                                    //   ),
                                    // );
                                    // CarApi.editCar(
                                    //   carInformation.id.toString(),
                                    // );
                                  },
                                  // ignore: prefer_const_constructors
                                  icon: Icon(
                                    Icons.edit,
                                    size: 24.0,
                                  ),
                                  label: const Text('Edit'),
                                ),
                              ),
                              /** Delete car */
                              OutlinedButton.icon(
                                onPressed: () {
                                  showAlertDialog(
                                      context, carInformation.id.toString());
                                  // CarApi.deleteCar("63590d11cf8cb5f009c53314");
                                  // setState(() {
                                  //   futureCar = CarApi.deleteCar(
                                  //       "63590d11cf8cb5f009c53314");
                                  // });
                                },
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  color: Colors.red,
                                  Icons.delete_forever,
                                  size: 24.0,
                                ),
                                // ignore: prefer_const_constructors
                                label: Text('Delete',
                                    style: const TextStyle(color: Colors.red)),
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
              return Column(
                children: [
                  Center(
                    child: Image.asset(
                      'images/nocarscreen.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'It seems like there is no car here!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text('Please add one to share a ride.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0XFF0000EE), fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCarScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        // side: const BorderSide(color: Color(0xFF008CFF), width: 3),
                        primary: const Color(0xFF008CFF),
                        onPrimary: Colors.white,
                        fixedSize: const Size(150, 50),
                        textStyle: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      child: const Text("Add Your Car"),
                    ),
                  ),
                ],
              );
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

/** Dialog confirmation delete */

showAlertDialog(BuildContext context, String idCar) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );
  Widget continueButton = FlatButton(
    child: const Text("Yes, I'm sure!"),
    onPressed: () {
      print("idCar:  $idCar");
      Navigator.of(context).pop(); // dismiss dialog
      //CarApi.deleteCar(idCar); // Function to delete car from DB.
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Action confirmation"),
    content:
        const Text("Are you sure you want to delete your car information?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
