import 'package:carpoolapp/screens/confirm_ride_screen.dart';
import 'package:carpoolapp/screens/search_ride_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../apis/rides_api.dart';
import '../models/rides.dart';
import 'home_screen.dart';

class AvailableRidesPerSearchScreen extends StatefulWidget {
  final String Destination;
  final String Departure;
  const AvailableRidesPerSearchScreen(
      {Key? key, required this.Destination, required this.Departure})
      : super(key: key);

  @override
  State<AvailableRidesPerSearchScreen> createState() =>
      _AvailableRidesPerSearchScreenState();
}

class _AvailableRidesPerSearchScreenState
    extends State<AvailableRidesPerSearchScreen> {
  late Future<List<Rides>>? futureRides;
  late final DateFormat formatter;
  Future<List<Rides>>? ridesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ridesFuture =
        RidesApi.fetchRidesPerSearch(widget.Destination, widget.Departure);
  }
  void _loadData(id) {
    RidesApi.getRideById(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Available rides',
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
                builder: (context) => SearchDepartureScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
          //label: Text("Back"),
          label: Text("Back"),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: FutureBuilder<List<Rides>>(
        future: ridesFuture,
        builder: (context, snapshot) {
          print(snapshot.data!.length);
          if (snapshot.hasData && snapshot.data!.length > 0) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flexible(
                      child: GestureDetector(
                        onTap: () async{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmRideScreen(idCar: snapshot.data![index].id.toString()),
                            ),
                          );

                          // _loadData(snapshot.data![index].id
                          //     .toString());
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: const Color(0xFF008CFF),
                              ),
                              borderRadius:
                                  BorderRadius.circular(10.0), //<-- SEE HERE
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            color: const Color(0xffF8F8F8),
                            child: SizedBox(
                              width: 400,
                              height: 210,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.my_location,
                                              color: Color(0xFF008CFF)),
                                          const Text(
                                            'Departure location: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              snapshot.data![index].Destination
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'DM Sans',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              color: Color(0xFF008CFF)),
                                          const Text(
                                            'Destination: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot
                                                .data![index].Departure_Location
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.date_range,
                                              color: Color(0xFF008CFF)),
                                          const Text(
                                            'Date of pick up: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].Departure_Date
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.timer,
                                              color: Color(0xFF008CFF)),
                                          const Text(
                                            'Time of pick up: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].Departure_Time
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.money,
                                            color: Color(0xFF008CFF),
                                          ),
                                          const Text(
                                            'Fees: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].Ride_Fees
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ); //SizedBox
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            // No data found in the snapshot which means no rides!
            return Padding(
              padding: EdgeInsetsDirectional.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'images/emptyWindow.png',
                          width: 360,
                          height: 360,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'It seems like there is no rides here!',
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
                        'Please try another time.',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: Color(0xFF0000EE),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
