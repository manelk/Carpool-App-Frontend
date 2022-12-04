import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class GooglePlaces extends StatefulWidget {
  const GooglePlaces({super.key});

  @override
  State<GooglePlaces> createState() => _GooglePlacesState();
}

class _GooglePlacesState extends State<GooglePlaces> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "1235";
  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
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

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: "Search places with name"),
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                height: 200,
                child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(
                              _placesList[index]['description']);
                          /** This is the option selected */
                          print(_placesList[index]['description']);
                          print(locations.last.longitude);
                          print(locations.last.latitude);
                        },
                        title: Text(_placesList[index]['description']),
                        leading: Icon(Icons.pin_drop),
                      );
                    })),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
