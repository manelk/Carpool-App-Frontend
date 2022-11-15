// // import 'dart:convert';

// // import 'package:carpoolapp/models/car.dart';
// // import 'package:flutter/material.dart';
// // import 'package:carpoolapp/screens/home_screen.dart';
// // import 'package:http/http.dart' as http;

// // class CarInformationScreen extends StatefulWidget {
// //   const CarInformationScreen({Key? key}) : super(key: key);

// //   @override
// //   State<CarInformationScreen> createState() => _CarInformationScreenState();
// // }

// // class _CarInformationScreenState extends State<CarInformationScreen> {
// //   @override
// //   void initState() {
// //     late Future<Car> futureCar;
// //     // TODO: implement initState
// //     super.initState();
// //     futureCar = fetchCar();

// //     // print("whatever");
// //     // var x = getCarInformation().then((value) => {
// //     //       for (var element in value) {print(element["_id"])}
// //     //     });
// //   }

// //   List<String> litems = ["1", "2", "Third", "4"];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: const Text(
// //           'My car information',
// //           style: TextStyle(color: Color(0xFF008CFF)),
// //         ),
// //         backgroundColor: Color(0xFFF8F8F8),
// //         automaticallyImplyLeading: false,
// //         actions: [],
// //         elevation: 2,
// //       ),
// //       body: new ListView.builder(
// //           itemCount: litems.length,
// //           itemBuilder: (BuildContext ctxt, int index) {
// //             return new Text(litems[index]);
// //           }),
// //       // body: SafeArea(
// //       //   child: SingleChildScrollView(
// //       //     child: GestureDetector(
// //       //       onTap: () => FocusScope.of(context).unfocus(),
// //       //       child: Padding(
// //       //         padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
// //       //         child: Column(
// //       //           mainAxisSize: MainAxisSize.max,
// //       //           children: [
// //       //             Row(
// //       //               mainAxisSize: MainAxisSize.max,
// //       //               mainAxisAlignment: MainAxisAlignment.center,
// //       //               children: [
// //       //                 Expanded(
// //       //                   child: Image.asset(
// //       //                     'images/passengercar2.png',
// //       //                     width: 150,
// //       //                     height: 150,
// //       //                     fit: BoxFit.contain,
// //       //                   ),
// //       //                 ),
// //       //               ],
// //       //             ),
// //       //             Padding(
// //       //               padding: const EdgeInsets.all(20),
// //       //               child: Row(
// //       //                 mainAxisSize: MainAxisSize.max,
// //       //                 mainAxisAlignment: MainAxisAlignment.start,
// //       //                 children: [
// //       //                   Text(
// //       //                     'Car Brand:',
// //       //                     style: TextStyle(
// //       //                       fontSize: 20,
// //       //                       fontFamily: 'DM Sans',
// //       //                       color: Color(0xFF008CFF),
// //       //                       fontWeight: FontWeight.w500,
// //       //                     ),
// //       //                   ),
// //       //                 ],
// //       //               ),
// //       //             ),
// //       //             Padding(
// //       //               padding: const EdgeInsets.all(20),
// //       //               child: Row(
// //       //                 mainAxisSize: MainAxisSize.max,
// //       //                 mainAxisAlignment: MainAxisAlignment.start,
// //       //                 children: [
// //       //                   Text(
// //       //                     'Car Model:',
// //       //                     style: TextStyle(
// //       //                       fontSize: 20,
// //       //                       fontFamily: 'DM Sans',
// //       //                       color: Color(0xFF008CFF),
// //       //                       fontWeight: FontWeight.w500,
// //       //                     ),
// //       //                   ),
// //       //                 ],
// //       //               ),
// //       //             ),
// //       //             Padding(
// //       //               padding: const EdgeInsets.all(20),
// //       //               child: Row(
// //       //                 mainAxisSize: MainAxisSize.max,
// //       //                 mainAxisAlignment: MainAxisAlignment.start,
// //       //                 children: [
// //       //                   Text(
// //       //                     'Car Color:',
// //       //                     style: TextStyle(
// //       //                       fontSize: 20,
// //       //                       fontFamily: 'DM Sans',
// //       //                       color: Color(0xFF008CFF),
// //       //                       fontWeight: FontWeight.w500,
// //       //                     ),
// //       //                   ),
// //       //                 ],
// //       //               ),
// //       //             ),

// //       //             //  FutureBuilder(future: getCarInformation(), builder: (context, (context, snapshot) => ),)
// //       //           ],
// //       //         ),
// //       //       ),
// //       //     ),
// //       //   ),
// //       // ),
// //     );
// //   }

// //   Future<Car> fetchCar() async {
// //     final response =
// //         await http.get(Uri.parse('http://10.0.2.2:3100/Api/user/getCarByUser'));

// //     if (response.statusCode == 200) {
// //       // If the server did return a 200 OK response,
// //       // then parse the JSON.
// //       return Car.fromJson(jsonDecode(response.body));
// //     } else {
// //       // If the server did not return a 200 OK response,
// //       // then throw an exception.
// //       throw Exception('Failed to load album');
// //     }
// //   }

// //   Future<List> getCarInformation() async {
// //     print('****************');
// //     var url = 'http://10.0.2.2:3100/Api/user/getCarByUser';
// //     var response = await http.get(
// //       url,
// //       headers: {
// //         'Content-Type': 'application/json',
// //       },
// //     );
// //     // Map<String, dynamic> carMap = jsonDecode(response.body);
// //     // var car = Car.fromJson(carMap["CarByUser"]);
// //     // print('Howdy, ${car.color}!');

// //     var data = jsonDecode(response.body);
// //     print("data");
// //     var CarInformation = data["CarByUser"];
// //     //print(CarInformation);
// //     //print("type is ${CarInformation.runtimeType}");
// //     // (jsonDecode(CarInformation) as List)
// //     //     .map((e) => e as Map<String, dynamic>)
// //     //     .toList();
// //     // print("type is ${CarInformation.runtimeType}");
// //     // CarInformation.forEach((key, value) {
// //     //   print(key);
// //     // });
// //     //print(rep["CarManufacturerList"]);
// //     // print(CarManufacturerList);
// //     // var List = [];
// //     // for (var element in CarInformation {
// //     //   List.add(element);
// //     // }
// //     //print("haja");
// //     //print(List);
// //     return CarInformation;
// //   }
// // }


// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // void main() {
// //   runApp(MyApp()); 
// // }

// // class MyApp extends StatelessWidget{
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         title: "Test App",
// //         home: HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget{
// //   @override
// //   State<StatefulWidget> createState() {
// //     return _HomePage();
// //   }
// // }

// // class _HomePage extends State<HomePage>{
// //   TextEditingController timeinput = TextEditingController(); 
// //   //text editing controller for text field
  
// //   @override
// //   void initState() {
// //     timeinput.text = ""; //set the initial value of text field
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //             title:Text("TimePicker on TextField"), 
// //             backgroundColor: Colors.redAccent, //background color of app bar
// //         ),
// //         body:Container(
// //           padding: EdgeInsets.all(15),
// //           height:150,
// //           child:Center( 
// //              child:TextField(
// //                 controller: timeinput, //editing controller of this TextField
// //                 decoration: InputDecoration( 
// //                    icon: Icon(Icons.timer), //icon of text field
// //                    labelText: "Enter Time" //label text of field
// //                 ),
// //                 readOnly: true,  //set it true, so that user will not able to edit text
// //                 onTap: () async {
// //                   TimeOfDay pickedTime =  await showTimePicker(
// //                           initialTime: TimeOfDay.now(),
// //                           context: context,
// //                       );
                  
// //                   if(pickedTime != null ){
// //                       print(pickedTime.format(context));   //output 10:51 PM
// //                       DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
// //                       //converting to DateTime so that we can further format on different pattern.
// //                       print(parsedTime); //output 1970-01-01 22:53:00.000
// //                       String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
// //                       print(formattedTime); //output 14:59:00
// //                       //DateFormat() is from intl package, you can format the time on any pattern you need.

// //                       setState(() {
// //                         timeinput.text = formattedTime; //set the value of text field. 
// //                       });
// //                   }else{
// //                       print("Time is not selected");
// //                   }
// //                 },
// //              )
// //           )
// //         )
// //     );
// //   }
// // }

// import 'package:carpoolapp/models/rides.dart';
// import 'package:flutter/material.dart';

// import 'home_screen.dart';

// import 'package:carpoolapp/models/rides.dart';
// import 'package:carpoolapp/apis/rides_api.dart';

// void main() {
//   runApp(RidesPublishedScreen());
// }

// class RidesPublishedScreen extends StatefulWidget {
//   @override
//   State<RidesPublishedScreen> createState() => _RidesPublishedScreenState();
// }

// class _RidesPublishedScreenState extends State<RidesPublishedScreen> {
//   late Future<Rides>? futureRides;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     futureRides = RidesApi.fetchRidesPerUser();
//     print("working on rides published");
//     FutureBuilder<Rides>(
//       future: futureRides,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           var data = snapshot.data!;
//           //return Text(data.brand!);
//         } else {
//           if (snapshot.hasError) {
//             print("Error");
//             return Text('${snapshot.error}');
//           }
//         }
//         //By default, show a loading spinner.
//         print("faza default");
//         return const CircularProgressIndicator();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Your available rides',
//           style: TextStyle(color: Colors.black),
//         ),
//         leadingWidth: 100,
//         backgroundColor: Color.fromRGBO(248, 248, 248, 1),
//         automaticallyImplyLeading: false,
//         leading: ElevatedButton.icon(
//           onPressed: () async {
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomeScreen(),
//               ),
//             );
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           label: Text("Back"),
//           style: ElevatedButton.styleFrom(
//             primary: Colors.transparent,
//             elevation: 0,
//           ),
//         ),
//       ),
//       body: Center(
//           child: FutureBuilder<Rides>(
//         future: futureRides,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var RidesInformation = snapshot.data;
//             print("RidesInformation");
//             print(RidesInformation?.Destination.toString());
//             // return Text(testa!);
//        } else {
//             if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             }
//           }

//           //By default, show a loading spinner.
//           return const CircularProgressIndicator(
//             value: 20,
//           );
//         },
//       )),

//       /*  body: Padding(
//         padding: const EdgeInsets.all(8.0),
//           child: FutureBuilder<Rides>(
//             future: futureRides,
//             builder: (context, snapshot) => {
//               if (snapshot.hasData) {
//               var ridesInformation = snapshot.data;
//               }
//            },
//           /*child: Card(
//             elevation: 50,
//             shadowColor: Colors.black,
//             color: Color(0xffF8F8F8),
//             child: SizedBox(
//               width: 400,
//               height: 180,
//               child: Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Departure location: ',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'DM Sans',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Destination: ',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'DM Sans',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Date of pick up: ',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'DM Sans',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Time of pick up: ',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'DM Sans',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Fees: ',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'DM Sans',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               /*child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Departure location: ',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontFamily: 'DM Sans',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Destination: ',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontFamily: 'DM Sans',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     //SizedBox
//                   ],
//                 ), //Column
//               ), //Padding
//           */
//             ), //SizedBox
//           ),*/
//         ),
//       ), //Center
//    */
//     );
//   }
// }
