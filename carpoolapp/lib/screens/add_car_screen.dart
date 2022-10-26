import 'dart:convert';
import 'dart:developer';
// import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/dialog_screen.dart';
import 'package:carpoolapp/screens/share_ride.dart';

import 'package:carpoolapp/apis/car_api.dart';

void main() {
  runApp(AddCarScreen());
}

class AddCarScreen extends StatefulWidget {
  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  String selectedValue = "Other";
  String selectedValueManufacturer = "Ford";
  String selectedValueEnergyType = "Electric";
  String selectedValueColor = "Black";

  String model = "";
  String brand = "";
  String color = "";
  String energy_type = "";

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

  // List<DropdownMenuItem<String>> get dropdownItemsModel {
  //   List<DropdownMenuItem<String>> menuItems = [
  //     DropdownMenuItem(child: Text("Chrysler"), value: "Chrysler"),
  //     DropdownMenuItem(child: Text("Honda"), value: "Honda"),
  //     DropdownMenuItem(child: Text("Mercedes-benz"), value: "Mercedes-benz"),
  //     DropdownMenuItem(child: Text("Ford"), value: "Ford"),
  //     DropdownMenuItem(child: Text("gmc"), value: "gmc"),
  //     DropdownMenuItem(child: Text("audi"), value: "audi"),
  //     DropdownMenuItem(child: Text("porsche"), value: "porsche"),
  //     DropdownMenuItem(child: Text("bmw"), value: "bmw"),
  //     DropdownMenuItem(child: Text("volvo"), value: "volvo"),
  //     DropdownMenuItem(child: Text("maserati"), value: "maserati"),
  //     DropdownMenuItem(child: Text("fiat"), value: "fiat"),
  //     DropdownMenuItem(child: Text("volkswagen"), value: "volkswagen"),
  //     DropdownMenuItem(child: Text("toyota"), value: "toyota"),
  //     DropdownMenuItem(child: Text("jeep"), value: "jeep"),
  //     DropdownMenuItem(child: Text("hyundai"), value: "hyundai"),
  //     DropdownMenuItem(child: Text("alfa-romeo"), value: "alfa-romeo"),
  //     DropdownMenuItem(child: Text("kia"), value: "kia"),
  //     DropdownMenuItem(child: Text("mazda"), value: "mazda"),
  //     DropdownMenuItem(child: Text("nissan"), value: "nissan"),
  //   ];
  //   return menuItems;
  // }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //List<DropdownMenuItem<String>> get dropdownItemsCarManufacturer {
  //   // CarManufacturerList = getManufacturer() as List;
  //   // print(CarManufacturerList);
  //   // var CarManufacturerList = getManufacturer();
  //   var lista = [];
  //   List<DropdownMenuItem<String>> menuItemss = [];
  //   menuItemss.add(
  //     DropdownMenuItem(child: Text("Other"), value: "Other"),
  //   );
  //   getManufacturer().then((value) => {
  //         for (var element in value) {lista.add(element)},
  //         for (var i = 0; i < lista.length; i++)
  //           {
  //             menuItemss.add(
  //               DropdownMenuItem(
  //                   child: Text(lista[i].toString()),
  //                   value: lista[i].toString()),
  //             ),
  //           },
  //         print("menuItemss.length"),
  //         print(menuItemss.length),
  //       });

  //   print('menuItemss.length####');
  //   // print(menuItemss.length);
  //   print(menuItemss.runtimeType);
  //   return menuItemss;
  // }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    //getManufacturer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add a car',
          style: TextStyle(color: Colors.black),
        ),
        leadingWidth: 100,
        backgroundColor: Color.fromRGBO(248, 248, 248, 1),
        automaticallyImplyLeading: false,
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
      ),
      body: SafeArea(
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
                          'images/passengercar1.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What is your car brand?',
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
                      value: selectedValueManufacturer,
                      items: dropdownItemsCarManufacturer,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueManufacturer = newValue!;
                          brand = newValue;
                        });
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'What is your car model?',
                  //         style: TextStyle(
                  //           fontFamily: 'DM Sans',
                  //           color: Color(0xFF008CFF),
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: DropdownButtonFormField(
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //     ),
                  //     icon: const Icon(Icons.arrow_drop_down_circle,
                  //         color: Color(0xFF008CFF)),
                  //     value: selectedValue,
                  //     items: dropdownItems,
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         model = newValue!;
                  //       });
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What is the color of your car ?',
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
                      value: selectedValueColor,
                      items: dropdownItemsColor,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueColor = newValue!;
                          color = newValue;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What is the car energy type ?',
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
                      value: selectedValueEnergyType,
                      items: dropdownItemsEnergyType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueEnergyType = newValue!;
                          energy_type = newValue;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Confirm"),
                    onPressed: () {
                      //getManufacturer();
                      CarApi.postCars(brand, model, color, energy_type);
                      //postCars(brand, model, color, energy_type);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShareRideScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF008CFF),
                      onPrimary: Colors.white,
                      fixedSize: Size(150, 50),
                      textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                    ),
                  ),
                  // FutureBuilder(
                  //     future: getManufacturer(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //       return const Text("Testing this out");
                  //     }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
