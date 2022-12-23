import 'package:carpoolapp/screens/search_ride_screen.dart';
import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/share_ride.dart';
import 'package:carpoolapp/screens/rides_published_screen.dart';
import 'package:intl/intl.dart';

import '../apis/rides_api.dart';
import '../models/rides.dart';
import 'confirm_ride_screen.dart';

void main() {
  runApp(const WelcomeScreen());
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Future<List<Rides>>? futureRides;
  late final DateFormat formatter;
  Future<List<Rides>>? ridesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ridesFuture = RidesApi.fetchRidesPerUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          automaticallyImplyLeading: false,
          title: const Text(
            'Carpool',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          elevation: 2,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // What are you looking for today?
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'What are you looking for today?',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              // Buttons
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            //builder: (context) => AddCarScreen(),
                            builder: (context) => SearchDepartureScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF37A33B),
                        onPrimary: Colors.white,
                        fixedSize: const Size(130, 40),
                        textStyle: const TextStyle(
                            fontFamily: 'DM Sans', fontSize: 13),
                      ),
                      child: const Text("Find a ride"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            //builder: (context) => AddCarScreen(),
                            builder: (context) => ShareRideScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF008CFF), width: 3),
                        primary: const Color(0xFFF8F8F8),
                        onPrimary: Colors.black,
                        fixedSize: const Size(130, 40),
                        textStyle: const TextStyle(
                            fontFamily: 'DM Sans', fontSize: 13),
                      ),
                      child: const Text("Publish a ride"),
                    ),
                  ],
                ),
              ),
              // Row that contains the sentence "Available Rides"
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: Text(
                      'Available Rides',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 24,
                thickness: 1,
                color: Color(0xFF808080),
              ),
              Expanded(
                child: FutureBuilder<List<Rides>>(
                  future: ridesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
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
                                    print(snapshot.data![index].id.toString());
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ConfirmRideScreen(idCar: snapshot.data![index].id.toString()),
                                      ),
                                    );
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(
                                            10.0), //<-- SEE HERE
                                      ),
                                      elevation: 8,
                                      shadowColor: Colors.black,
                                      color: const Color(0xffF8F8F8),
                                      child: SizedBox(
                                        width: 400,
                                        height: 170,
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 10, 10, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                        height: 50,
                                                        child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                                size: 20.0,
                                                                Icons.my_location,
                                                                color: Colors.black87
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'Departure:',
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontFamily:
                                                                    'DM Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    //BoxDecoration
                                                  ), //Flexible
                                                  SizedBox(
                                                    width: 10,
                                                  ), //SizedBox
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      height: 50,
                                                      child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .Departure_Location
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'DM Sans',
                                                              ),
                                                            ),
                                                          ]),
                                                    ), //Container
                                                  ) //Flexible
                                                ], //<Widget>[]
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                        height: 50,
                                                        child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                                size: 20.0,
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: Colors.black87),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'Destination:',
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontFamily:
                                                                    'DM Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    //BoxDecoration
                                                  ), //Flexible
                                                  SizedBox(
                                                    width: 10,
                                                  ), //SizedBox
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      height: 50,
                                                      child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .Destination
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'DM Sans',
                                                              ),
                                                            ),
                                                          ]),
                                                    ), //Container
                                                  ) //Flexible
                                                ], //<Widget>[]
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                              Divider(
                                                height: 20,
                                                thickness: 1,
                                                color: Color(0xFF808080),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment.start,
                                                        children: [
                                                          Icon(
                                                              size: 20.0,
                                                              Icons.schedule,
                                                              color:
                                                                  Color(0xFF008CFF)),

                                                          Text(
                                                            snapshot.data![index]
                                                                .Departure_Date
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontFamily: 'DM Sans',
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  VerticalDivider(width: 1.0),
                                                  Expanded(
                                                      child: Center(
                                                        child: Wrap(
                                                          crossAxisAlignment:
                                                          WrapCrossAlignment.start,
                                                          children: [
                                                            // Icon(
                                                            //     size: 20.0,
                                                            //     Icons.attach_money,
                                                            //     color:
                                                            //     Color(0xFF008CFF)),
                                                            Text(
                                                              snapshot.data![index]
                                                                  .Ride_Fees
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontFamily: 'DM Sans',
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              "TND",
                                                              style: TextStyle(
                                                                color: Color(0xFF008CFF),
                                                                fontSize: 15.0,
                                                                fontFamily: 'DM Sans',
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  )),
                                                ],
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
                      return Text('${snapshot.error}');
                    }
                     return Center(child: const CircularProgressIndicator(
                       backgroundColor: const Color(0xFF008CFF),
                       valueColor:  AlwaysStoppedAnimation(Colors.white54),
                     ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
