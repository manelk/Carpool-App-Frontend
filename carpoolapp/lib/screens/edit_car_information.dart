import 'dart:convert';
import 'dart:developer';
// import 'dart:ffi';
import 'package:carpoolapp/screens/car_information_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/dialog_screen.dart';
import 'package:carpoolapp/screens/share_ride.dart';

import 'package:carpoolapp/apis/car_api.dart';

import '../models/car.dart';

class EditCarScreen extends StatefulWidget {
  EditCarScreen({Key? key, required this.id});
  final String id;

  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  late Future<Car>? futureCar;
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController energyTypeController = TextEditingController();
  List<DropdownMenuItem<String>> get dropdownItemsCarManufacturer {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Chrysler"), value: "Chrysler"),
      DropdownMenuItem(child: Text("Honda"), value: "Honda"),
      DropdownMenuItem(child: Text("Mercedes-benz"), value: "Mercedes-benz"),
      DropdownMenuItem(child: Text("Ford"), value: "Ford"),
      DropdownMenuItem(child: Text("gmc"), value: "gmc"),
      DropdownMenuItem(child: Text("audi"), value: "audi"),
      DropdownMenuItem(child: Text("porsche"), value: "porsche"),
      DropdownMenuItem(child: Text("bmw"), value: "bmw"),
      DropdownMenuItem(child: Text("volvo"), value: "volvo"),
      DropdownMenuItem(child: Text("maserati"), value: "maserati"),
      DropdownMenuItem(child: Text("fiat"), value: "fiat"),
      DropdownMenuItem(child: Text("volkswagen"), value: "volkswagen"),
      DropdownMenuItem(child: Text("toyota"), value: "toyota"),
      DropdownMenuItem(child: Text("jeep"), value: "jeep"),
      DropdownMenuItem(child: Text("hyundai"), value: "hyundai"),
      DropdownMenuItem(child: Text("alfa-romeo"), value: "alfa-romeo"),
      DropdownMenuItem(child: Text("kia"), value: "kia"),
      DropdownMenuItem(child: Text("mazda"), value: "mazda"),
      DropdownMenuItem(child: Text("nissan"), value: "nissan"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsColor {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("White"), value: "White"),
      DropdownMenuItem(child: Text("Black"), value: "Black"),
      DropdownMenuItem(child: Text("Gray"), value: "Gray"),
      DropdownMenuItem(child: Text("Silver"), value: "Silver"),
      DropdownMenuItem(child: Text("Red"), value: "Red"),
      DropdownMenuItem(child: Text("Blue"), value: "Blue"),
      DropdownMenuItem(child: Text("Brown"), value: "Brown"),
      DropdownMenuItem(child: Text("Green"), value: "Green"),
      DropdownMenuItem(child: Text("Beige"), value: "Beige"),
      DropdownMenuItem(child: Text("Orange"), value: "Orange"),
      DropdownMenuItem(child: Text("Gold"), value: "Gold"),
      DropdownMenuItem(child: Text("Yellow"), value: "Yellow"),
      DropdownMenuItem(child: Text("Purple"), value: "Purple"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsEnergyType {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Gasoline"), value: "Gasoline"),
      DropdownMenuItem(child: Text("Diesel"), value: "Diesel"),
      DropdownMenuItem(child: Text("Electric"), value: "Electric"),
      DropdownMenuItem(
          child: Text("Hybrid Electric"), value: "Hybrid Electric"),
      DropdownMenuItem(
          child: Text("Plug-in Hybrid Electric"),
          value: "Plug-in Hybrid Electric"),
    ];
    return menuItems;
  }

  String brand = "";
  String model = "";
  String color = "";
  String energy_type = "";
  String id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCar = CarApi.getCarById(widget.id);
    print(futureCar);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        leading: ElevatedButton.icon(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
          label: Text("Back"),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
          ),
        ),
        title: const Text(
          'Edit Your Car Information',
          style: TextStyle(color: Colors.black),
        ),
        leadingWidth: 100,
        backgroundColor: Color.fromRGBO(248, 248, 248, 1),
        automaticallyImplyLeading: false,

      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FutureBuilder<Car>(
            future: futureCar,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var carInformation = snapshot.data;
                id = carInformation!.id.toString();
                // String model = carInformation!.model.toString();
                // String color = carInformation.color.toString();
                // String energy_type = carInformation.energy_type.toString();
                // brandController.text = brand;
                String selectedValueManufacturer =
                    carInformation.brand.toString();
                String selectedValueModel = carInformation.model.toString();
                String selectedValueEnergy =
                    carInformation.energy_type.toString();
                return SafeArea(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'Car brand',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: Color(0xFF008CFF),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_drop_down_circle,
                                    color: Color(0xFF008CFF)),
                                value: carInformation.brand.toString(),
                                items: dropdownItemsCarManufacturer,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValueManufacturer = newValue!;
                                    if (newValue.isEmpty) {
                                      brand = selectedValueManufacturer;
                                    } else {
                                      brand = newValue;
                                      print(brand);
                                      // brandController.text = newValue;
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'Car Color',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: Color(0xFF008CFF),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_drop_down_circle,
                                    color: Color(0xFF008CFF)),
                                value: carInformation.color.toString(),
                                items: dropdownItemsColor,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValueManufacturer = newValue!;
                                    if (newValue.isEmpty) {
                                      color = selectedValueModel;
                                    } else {
                                      color = newValue;
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'Car energy type',
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: Color(0xFF008CFF),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_drop_down_circle,
                                    color: Color(0xFF008CFF)),
                                value: carInformation.energy_type.toString(),
                                items: dropdownItemsEnergyType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValueEnergy = newValue!;
                                    if (newValue.isEmpty) {
                                      energy_type = selectedValueEnergy;
                                    } else {
                                      energy_type = newValue;
                                      // brandController.text = newValue;
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (brand.isEmpty) {
                                    brand = carInformation.brand.toString();
                                  }
                                  if (color.isEmpty) {
                                    color = carInformation.color.toString();
                                  }
                                  if (energy_type.isEmpty) {
                                    energy_type =
                                        carInformation.energy_type.toString();
                                  }
                                  print("#################");
                                  print(brand);
                                  print(color);
                                  print(energy_type);
                                  print(id);
                                  CarApi.editCar(id, brand, color, energy_type);
                                 // Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF008CFF),
                                  onPrimary: Colors.white,
                                  fixedSize: Size(150, 50),
                                  textStyle: TextStyle(
                                      fontFamily: 'DM Sans', fontSize: 19),
                                ),
                                child: const Text("Save changes"),
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
                  return Center(child: Text("Som"));
                }
              }
              return const CircularProgressIndicator(
                value: 20,
              );
            }),
      ),
    );
  }
}
