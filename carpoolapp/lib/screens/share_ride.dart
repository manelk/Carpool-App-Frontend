import 'dart:convert';

import 'package:carpoolapp/config.dart';
import 'package:carpoolapp/screens/rides_published_screen.dart';
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/apis/rides_api.dart';
import 'package:carpoolapp/apis/google_api.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'add_car_screen.dart';

void main() {
  runApp(ShareRideScreen());
}

class ShareRideScreen extends StatefulWidget {
  @override
  State<ShareRideScreen> createState() => _ShareRideScreenState();
}

class _ShareRideScreenState extends State<ShareRideScreen> {
  final FocusNode _focus = FocusNode();
  var noCar = 0;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _DestinationController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "1235";
  String _sessionTokenDestination = "12356";
  List<dynamic> _placesList = [];
  List<dynamic> _placesListDestination = [];
  TextEditingController timeinput = TextEditingController();
  final _dateController = TextEditingController();

  /// TextField controllers */s
  TextEditingController DepartureLocationController = TextEditingController();
  TextEditingController DepartureDateController = TextEditingController();
  TextEditingController DepartureTimeController = TextEditingController();
  TextEditingController RideFeesController = TextEditingController();

  String Destination = '';
  String Departure_Date = '';
  String Departure_Location = '';
  String Departure_Time = '';
  String Ride_Fees = '';
  late bool isShowListTile = true;
  late bool isShowListTileDestination = true;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
    _DestinationController.addListener(() {
      onChangeDestination();
    });
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }


  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
    // getSuggestion(_DestinationController.text);
  }

  void onChangeDestination() {
    if (_sessionToken == null) {
      setState(() {
        _sessionTokenDestination = uuid.v4();
      });
    }
    getSuggestionDestination(_DestinationController.text);
  }

  void getSuggestion(String input) async {
    String kPlaces_Api_Key = "AIzaSyD6hhlx6VoL2n0HRnwuiTeZwuRN0_og0ys";
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$baseURL?input=$input&key=$kPlaces_Api_Key&sessionToken=$_sessionToken';
    // print(
    //     '$baseURL?input=$input&key=$kPlaces_Api_Key&sessionToken=$_sessionToken');
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void getSuggestionDestination(String input) async {
    String kPlaces_Api_Key = "AIzaSyD6hhlx6VoL2n0HRnwuiTeZwuRN0_og0ys";
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$baseURL?input=$input&key=$kPlaces_Api_Key&sessionToken=$_sessionTokenDestination';
    // print(
    //     '$baseURL?input=$input&key=$kPlaces_Api_Key&sessionToken=$_sessionToken');
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        _placesListDestination =
            jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);
  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final googleMapWidget = GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 14.0,
      ),
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      mapToolbarEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      padding: const EdgeInsets.only(top: 300),
    );

    final destinationLocationWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.2,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
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
                  padding: const EdgeInsets.all(8.0),
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focus) => debugPrint("focus: $focus"),
                      child: TextFormField(
                      onTap: () {
                        print("hkeya");
                        print('Editing stated $widget');
                      },
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Your location',
                        prefixIcon: const Icon(Icons.my_location),
                      ),
                    ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isShowListTile,
                  child: Expanded(
                      child: Container(
                    color: Color(0xffF8F8F8),
                    height: 200,
                    child: ListView.builder(
                        itemCount: _placesList.length,
                        itemBuilder: ((context, index) {
                          return Visibility(
                            visible: isShowListTile,
                            child: ListTile(
                              onTap: () async {
                                List<Location> locations =
                                    await locationFromAddress(
                                        _placesList[index]['description']);
                                _controller.text =
                                    _placesList[index]['description'];
                                Departure_Location =
                                    _placesList[index]['description'];
                                ;
                                /** This is the option selected */
                                print(_placesList[index]['description']);
                                print(locations.last.longitude);
                                print(locations.last.latitude);
                                isShowListTile = false;
                              },
                              title: Text(_placesList[index]['description']),
                              leading: Icon(Icons.pin_drop),
                            ),
                          );
                        })),
                  )),
                ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _DestinationController,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'The destination',
                      prefixIcon: const Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
                Visibility(
                  visible: isShowListTileDestination,
                  child: Expanded(
                      child: Container(
                    color: Color(0xffF8F8F8),
                    height: 200,
                    child: ListView.builder(
                        itemCount: _placesListDestination.length,
                        itemBuilder: ((context, index) {
                          return Visibility(
                            visible: isShowListTileDestination,
                            child: ListTile(
                              onTap: () async {
                                List<Location> locationDestination =
                                    await locationFromAddress(
                                        _placesListDestination[index]
                                            ['description']);
                                _DestinationController.text =
                                    _placesListDestination[index]
                                        ['description'];
                                Destination = _placesListDestination[index]
                                    ['description'];

                                /** This is the option selected */
                                print(_placesListDestination[index]
                                    ['description']);
                                print(locationDestination.last.longitude);
                                print(locationDestination.last.latitude);
                                isShowListTileDestination = false;
                              },
                              title: Text(
                                  _placesListDestination[index]['description']),
                              leading: Icon(Icons.location_on_outlined),
                            ),
                          );
                        })),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'What time is the departure?',
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
                    controller: timeinput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                      hintText: "Departure time", //icon of text field
                    ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                            DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.
                        setState(() {
                          /** Setting Departure_Time to Time input controller */
                          timeinput.text = formattedTime;
                          Departure_Time = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
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
                        'What date ?',
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
                  child: _datePicker(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'What is the ride fees?',
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                      controller: RideFeesController,

                      onChanged: (text) {
                        setState(() {
                          Ride_Fees = text;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '0,000',
                        prefixIcon: Icon(Icons.money),
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(Destination + Departure_Location);
                    RidesApi.postRide(Destination, Departure_Location,
                        Departure_Date, Departure_Time, Ride_Fees);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RidesPublishedScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF008CFF),
                    onPrimary: Color(0xffF8F8F8),
                    fixedSize: const Size(150, 50),
                    textStyle:
                        const TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                  ),
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  /*  if (noCar == 0) {  return Scaffold(
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
                          'images/nocarscreen.png',
                          width: 360,
                          height: 270,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'It seems like there is no car here!',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Please add one to share a ride.',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: Color(0xFF0000EE),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //CarApi.postCars(brand, model, color, energy_type);
                        noCar=1;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCarScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF008CFF),
                        onPrimary: Colors.white,
                        fixedSize: Size(150, 50),
                        textStyle:
                        TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                      ),
                      child: const Text("Add a car"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    }*/
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
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            label: const Text("Back"),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 1.2,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: Key("departure_text_field"),
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Your location',
                          prefixIcon: const Icon(Icons.my_location),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isShowListTile,
                      child: Expanded(
                          child: Container(
                            color: Color(0xffF8F8F8),
                            height: 200,
                            child: ListView.builder(
                                itemCount: _placesList.length,
                                itemBuilder: ((context, index) {
                                  return Visibility(
                                    visible: isShowListTile,
                                    child: ListTile(
                                      onTap: () async {
                                        List<Location> locations =
                                        await locationFromAddress(
                                            _placesList[index]['description']);
                                        _controller.text =
                                        _placesList[index]['description'];
                                        Departure_Location =
                                        _placesList[index]['description'];
                                        ;
                                        /** This is the option selected */
                                        print(
                                            _placesList[index]['description']);
                                        print(locations.last.longitude);
                                        print(locations.last.latitude);
                                        isShowListTile = false;
                                      },
                                      title: Text(
                                          _placesList[index]['description']),
                                      leading: Icon(Icons.pin_drop),
                                    ),
                                  );
                                })),
                          )),
                    ),
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: Key("destination_text_field"),
                        controller: _DestinationController,
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'The destination',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isShowListTileDestination,
                      child: Expanded(
                          child: Container(
                            color: Color(0xffF8F8F8),
                            height: 200,
                            child: ListView.builder(
                                itemCount: _placesListDestination.length,
                                itemBuilder: ((context, index) {
                                  return Visibility(
                                    visible: isShowListTileDestination,
                                    child: ListTile(
                                      onTap: () async {
                                        List<Location> locationDestination =
                                        await locationFromAddress(
                                            _placesListDestination[index]
                                            ['description']);
                                        _DestinationController.text =
                                        _placesListDestination[index]
                                        ['description'];
                                        Destination =
                                        _placesListDestination[index]
                                        ['description'];

                                        /** This is the option selected */
                                        print(_placesListDestination[index]
                                        ['description']);
                                        print(
                                            locationDestination.last.longitude);
                                        print(
                                            locationDestination.last.latitude);
                                        isShowListTileDestination = false;
                                      },
                                      title: Text(_placesListDestination[index]
                                      ['description']),
                                      leading: Icon(Icons.location_on_outlined),
                                    ),
                                  );
                                })),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'What time is the departure?',
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
                        key: Key("time_text_field"),
                        controller: timeinput,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(Icons.timer),
                          hintText: "Departure time", //icon of text field
                        ),
                        readOnly:
                        true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                            DateFormat('HH:mm').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.
                            setState(() {
                              /** Setting Departure_Time to Time input controller */
                              timeinput.text = formattedTime;
                              Departure_Time = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
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
                            'What date ?',
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
                      child: _datePicker(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'What is the ride fees?',
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
                          key: Key("fees_text_field"),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                          controller: RideFeesController,
                          onChanged: (text) {
                            setState(() {
                              Ride_Fees = text;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '0,000',
                            prefixIcon: Icon(Icons.money),
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(Destination + Departure_Location);
                        RidesApi.postRide(Destination, Departure_Location,
                            Departure_Date, Departure_Time, Ride_Fees);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RidesPublishedScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF008CFF),
                        onPrimary: Color(0xffF8F8F8),
                        fixedSize: const Size(150, 50),
                        textStyle:
                        const TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                      ),
                      child: const Text("Save"),
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
      key: Key("date_text_field"),
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
