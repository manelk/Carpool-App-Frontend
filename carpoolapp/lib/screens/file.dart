import 'dart:convert';

import 'package:carpoolapp/config.dart';
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/dialog_screen.dart';
import 'package:carpoolapp/screens/ride_screen.dart';
import 'package:carpoolapp/screens/rides_published_screen.dart';
import 'package:carpoolapp/apis/rides_api.dart';
import 'package:carpoolapp/apis/google_api.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ShareRideScreen());
}

class ShareRideScreen extends StatefulWidget {
  @override
  State<ShareRideScreen> createState() => _ShareRideScreenState();
}

class _ShareRideScreenState extends State<ShareRideScreen> {
  TextEditingController timeinput = TextEditingController();
  final _dateController = TextEditingController();

  /// TextField controllers */
  static late TextEditingController _DestinationController =
      TextEditingController();
  TextEditingController DepartureLocationController = TextEditingController();
  TextEditingController DepartureDateController = TextEditingController();
  TextEditingController DepartureTimeController = TextEditingController();
  TextEditingController RideFeesController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  String Destination = '';
  String Departure_Date = '';
  String Departure_Location = '';
  String Departure_Time = '';
  String Ride_Fees = '';

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timeinput.text = ""; //set the initial value of text field

    _DestinationController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_DestinationController.text);
    //print(_DestinationController.text);
  }

  void getSuggestion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&sessiontoken=$_sessionToken&key=$mapKey';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("response ###");
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Share ride availability',
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
                  /*  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'From where?',
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
                    child: TextField(
                        controller: DepartureLocationController,
                        onChanged: (text) {
                          //print(text);
                          setState(() {
                            Departure_Location = text;
                          });
                        },
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Your location',
                          prefixIcon: const Icon(Icons.my_location),
                        )),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'To where?',
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
                    padding: EdgeInsets.all(10),
                    child: TextField(
                        controller: _DestinationController,
                        keyboardType: TextInputType.text,

                        // onChanged: (text) {
                        //   //print(text);
                        //   //GoogleApi.findPlace(text);
                        //   setState(() {
                        //     D  estination = text;
                        //   });
                        // },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'The destination',
                          prefixIcon: Icon(Icons.location_on_outlined),
                        )),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _placesList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_placesList[index]['description']),
                        );
                      },
                    ),
                  ),
                  // Expanded(
                  //     child: SizedBox(
                  //   height: 200.0,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     shrinkWrap: true,
                  //     itemCount: _placesList.length,
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         title: Text(_placesList[index]['description']),
                  //       );
                  //     },
                  //   ),
                  // )),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     // ignore: prefer_const_literals_to_create_immutables
                  //     children: [
                  //       const Text(
                  //         'What time is the departure?',
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
                  //   child: TextField(
                  //     controller: timeinput,
                  //     //editing controller of this TextField
                  //     decoration: InputDecoration(
                  //       border: const OutlineInputBorder(),
                  //       prefixIcon: Icon(Icons.timer),
                  //       hintText: "Departure time", //icon of text field
                  //     ),
                  //     readOnly:
                  //         true, //set it true, so that user will not able to edit text
                  //     onTap: () async {
                  //       TimeOfDay? pickedTime = await showTimePicker(
                  //         initialTime: TimeOfDay.now(),
                  //         context: context,
                  //       );

                  //       if (pickedTime != null) {
                  //         print(pickedTime.format(context)); //output 10:51 PM
                  //         DateTime parsedTime = DateFormat.jm()
                  //             .parse(pickedTime.format(context).toString());
                  //         //converting to DateTime so that we can further format on different pattern.
                  //         print(parsedTime); //output 1970-01-01 22:53:00.000
                  //         String formattedTime =
                  //             DateFormat('HH:mm').format(parsedTime);
                  //         print(formattedTime); //output 14:59:00
                  //         //DateFormat() is from intl package, you can format the time on any pattern you need.
                  //         setState(() {
                  //           /** Setting Departure_Time to Time input controller */
                  //           timeinput.text = formattedTime;
                  //           Departure_Time = formattedTime;
                  //         });
                  //       } else {
                  //         print("Time is not selected");
                  //       }
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'What date ?',
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
                  //   child: _datePicker(),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     // ignore: prefer_const_literals_to_create_immutables
                  //     children: [
                  //       const Text(
                  //         'What is the ride fees?',
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
                  //   padding: EdgeInsets.all(10),
                  //   child: TextField(
                  //       inputFormatters: <TextInputFormatter>[
                  //         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  //       ],
                  //       keyboardType: TextInputType.number,
                  //       controller: RideFeesController,
                  //       onChanged: (text) {
                  //         setState(() {
                  //           Ride_Fees = text;
                  //         });
                  //       },
                  //       decoration: InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         hintText: 'Ride Fees',
                  //         prefixIcon: Icon(Icons.money),
                  //       )),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      // RidesApi.postRide(Destination, Departure_Location,
                      //     Departure_Date, Departure_Time, Ride_Fees);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RidesPublishedScreen(),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF008CFF),
                      onPrimary: Colors.white,
                      fixedSize: const Size(150, 50),
                      textStyle:
                          const TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                    ),
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _datePicker() {
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
          day.isBefore(DateTime.now().add(Duration(days: 30))))) {
        return true;
      }
      return false;
    }

    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.event),
        hintText: "Date",
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          // firstDate: DateTime(2000),
          // lastDate: DateTime(2100),
          firstDate: new DateTime(DateTime.now().year),
          lastDate: new DateTime(DateTime.now().year + 1),
          initialDate: DateTime.now(),
          //selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
          // selectableDayPredicate: (day) => day.isAfter(DateTime.now()),
          selectableDayPredicate: _decideWhichDayToEnable,
        );
        if (selectedDate != null) {
          setState(() {
            /** Setting Departure_Date that will be in post function to _dateController.text for date of departure */
            _dateController.text = DateFormat.yMd().format(selectedDate);
            print("####" + _dateController.text);
            Departure_Date = DateFormat.yMd()
                .format(selectedDate); //set the value of text field.
          });
        }
      },
    );
  }
}
