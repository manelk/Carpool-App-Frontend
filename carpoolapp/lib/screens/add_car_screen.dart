import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/dialog_screen.dart';
import 'package:carpoolapp/screens/share_ride.dart';

void main() {
  runApp(AddCarScreen());
}

class AddCarScreen extends StatefulWidget {
  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  String selectedValue = "USA";

  String model = "";
  String brand = "";
  String color = "";
  String energy_type = "";
  var CarManufacturerList;
  var tt = ['hhhh', 'ggggg', 'gggg'];
  List<DropdownMenuItem<String>> get dropdownItems {
    // CarManufacturerList = getManufacturer() as List;
    // print(CarManufacturerList);
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var x = getManufacturer().then((value) => print(value.length));
    //print("CarManufacturerList");
    print(x);
  }

  List<DropdownMenuItem<String>> get soumaya {
    // CarManufacturerList = getManufacturer() as List;
    // print(CarManufacturerList);
    var CarManufacturerList = getManufacturer();
    //print("CarManufacturerList");
    var lista = [];
    List<DropdownMenuItem<String>> menuItemss = [];

    getManufacturer().then((value) => {
          for (var element in value) {lista.add(element)},
          menuItemss.add(
            DropdownMenuItem(child: Text("USA"), value: "USA"),
          ),
          print(lista.length),
          print(menuItemss.length),
          print(lista[2].toString()),
          for (var i = 0; i < lista.length; i++)
            {
              print('reppp'),
              menuItemss.add(
                DropdownMenuItem(child: Text(lista[i]), value: lista[i]),
              )
            },
        });
    print('kjjjjjjjjjjjjjjjjjjj');
    print(menuItemss.length);
    //print(CarManufacturerList);
    /*   List<DropdownMenuItem<String>> menuItemss = [];
    menuItemss.add(
      DropdownMenuItem(child: Text("USA"), value: "USA"),
    );

    for (var i = 0; i < CarManufacturerList.length; i++) {
      menuItemss.add(
        DropdownMenuItem(
            child: Text(CarManufacturerList[i]), value: CarManufacturerList[i]),
      );
    }*/

    return menuItemss;
  }

  /*

   List<DropdownMenuItem<String>> get dropdownItemsManufacturer {
    CarManufacturerList = getManufacturer() as List;
    for (var element in CarManufacturerList) {
      print(element);
      DropdownMenuItem(child: element, value: element);
      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(child: element, value: element)
      ];
    }
    return menuItems;
  }
  */

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    CarManufacturerList = getManufacturer();
    print("CarManufacturerList");
    //print(CarManufacturerList);
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
                      value: selectedValue,
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          brand = newValue!;
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
                          'What is your car model?',
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
                      value: selectedValue,
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          model = newValue!;
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
                      value: selectedValue,
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          color = newValue!;
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
                      value: selectedValue,
                      //items: soumaya,
                      items: soumaya,
                      onChanged: (String? newValue) {
                        setState(() {
                          energy_type = newValue!;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Confirm"),
                    onPressed: () {
                      getManufacturer();
                      //postCars(brand, model, color, energy_type);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF008CFF),
                      onPrimary: Colors.white,
                      //fixedSize: Size(150, 50),
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

  Future<dynamic> postCars(String a, String b, String c, String d) async {
    print('****************');
    print(a);
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
    print('bnj');
  }

//  List<Manufacturer> Manufacturer = [];
  /* Future<dynamic> getAll() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:1337/apis/"));
      
    if(response.statusCode==200){
      user.clear();
    }
    var decodedData = jsonDecode(response.body);
    for (var u in decodedData) {
      user.add(Users(u['id'], u['name'], u['email'], u['password']));
    }
    return user;
  }*/
  Future<List> getManufacturer() async {
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
    //print("haja");
    //print(List);
    return List;
  }
}
