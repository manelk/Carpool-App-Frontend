import 'dart:async';

import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/rides_published_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carpoolapp/apis/google_api.dart';

import '../apis/rides_api.dart';
import 'available_rides_per_location.dart';

class SearchDepartureScreen extends StatefulWidget {
  const SearchDepartureScreen({Key? key}) : super(key: key);

  @override
  State<SearchDepartureScreen> createState() => _SearchDepartureScreenState();
}

class _SearchDepartureScreenState extends State<SearchDepartureScreen> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(33.7931605, 9.5607653);
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polyline = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  Future<void> _goToPlace(
    //Map<String, dynamic> place
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    //final double lat = place['geometry']['location']['lat'];
    //final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }

  @override
  void initState() {
    super.initState();
    _setMarker(LatLng(33.7931605, 9.5607653));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    // Each polygon have a different ID.
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polyline.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.deepOrange,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffF8F8F8),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Where Do You Wanna Go',
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _originController,
                            onChanged: (value) {
                              print(value);
                            },
                            decoration: const InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Origin',
                              prefixIcon: Icon(Icons.location_on),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _destinationController,
                            onChanged: (value) async {
                              var directions = await GoogleApi.getDirections(
                                  _originController.text,
                                  _destinationController.text);
                              _goToPlace(
                                directions['start_location']['lat'],
                                directions['start_location']['lng'],
                                directions['bounds_ne'],
                                directions['bounds_sw'],
                              );
                              _setPolyline(directions['polyline_decoded']);
                            },
                            decoration: const InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Destination',
                              prefixIcon: Icon(Icons.location_city),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AvailableRidesPerSearchScreen(Destination: _destinationController.text, Departure: _originController.text),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: const Color(0xFF008CFF),
                            onPrimary: Color(0xffF8F8F8),
                            fixedSize: const Size(150, 50),
                            textStyle: const TextStyle(
                                fontFamily: 'DM Sans', fontSize: 19),
                          ),
                          child: const Text("Find a ride"),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Stack(
//                     alignment: const Alignment(1.0, 1.0),
//                     children: <Widget>[
//                       TextFormField(
//                         key: Key("departure_text_field"),
//                         controller: _controllerDeparture,
// //                          textCapitalization: TextCapitalization.words,
//                         onChanged: (value) {
//                           print(value);
//                         },
//                         decoration: const InputDecoration(
//                           //   border: const OutlineInputBorder(),
//                           hintText: 'Select your departure city',
//                         ),
//                       ),
//                       IconButton(
//                           onPressed: () async {
//                             var place = await GoogleApi.getPlace(
//                                 _controllerDeparture.text);
//                             _goToPlace(place);
//                           },
//                           icon: Icon(Icons.search)),
//                     ]),
//               ),
              Expanded(
                child: GoogleMap(
                  onTap: (point) {
                    setState(() {
                      polygonLatLngs.add(point);
                      _setPolygon();
                    });
                  },
                  polylines: _polyline,
                  markers: _markers,
                  polygons: _polygons,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 8.5,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
