import 'package:carpoolapp/models/rides.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

import 'package:carpoolapp/models/rides.dart';
import 'package:carpoolapp/apis/rides_api.dart';

void main() {
  runApp(RidesPublishedScreen());
}

class RidesPublishedScreen extends StatefulWidget {
  @override
  State<RidesPublishedScreen> createState() => _RidesPublishedScreenState();
}

class _RidesPublishedScreenState extends State<RidesPublishedScreen> {
  late Future<Rides>? futureRides;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureRides = RidesApi.fetchRidesPerUser();
    print("working on rides published");
    FutureBuilder<Rides>(
      future: futureRides,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          print("data");

          print(data);
          //return Text(data.brand!);
        } else {
          if (snapshot.hasError) {
            print("Error");
            return Text('${snapshot.error}');
          }
        }
        //By default, show a loading spinner.
        print("faza default");
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your available rides',
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ElevatedButton(
                //   child: Text("Occasional rides"),
                //   onPressed: () {
                //     print('Button Avaible rides pressed ...');
                //   },
                //   style: ElevatedButton.styleFrom(
                //     elevation: 8,
                //     primary: Color(0xFFF8F8F8),
                //     onPrimary: Colors.black,
                //     fixedSize: Size(130, 40),
                //     textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                //   ),
                // ),
                // ElevatedButton(
                //   child: Text("Daily rides"),
                //   onPressed: () async {},
                //   style: ElevatedButton.styleFrom(
                //     elevation: 8,
                //     primary: Color(0xFFF8F8F8),
                //     onPrimary: Colors.black,
                //     fixedSize: Size(130, 40),
                //     textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                //   ),
                // ),
                ElevatedButton.icon(
                  onPressed: () {
                    print("You pressed Icon Elevated Button");
                  },
                  icon: Icon(Icons
                      .calendar_month_outlined), //icon data for elevated button
                  label: Text("Occasional Rides"), //label text
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: Color(0xFFF8F8F8),
                    onPrimary: Colors.black,
                    fixedSize: Size(130, 40),
                    textStyle:
                        const TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    print("You pressed Icon Elevated Button");
                  },
                  icon: Icon(Icons
                      .calendar_month_outlined), //icon data for elevated button
                  label: Text("Daily Rides"), //label text
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: Color(0xFFF8F8F8),
                    fixedSize: Size(130, 40),
                    onPrimary: Colors.black,
                    textStyle:
                        const TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: FutureBuilder<Rides>(
                future: futureRides,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var RidesInformation = snapshot.data;
                    print("RidesInformation");
                    print(RidesInformation?.Destination.toString());
                    // return Text(testa!);
                    return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xFF008CFF),
                          ),
                          borderRadius:
                              BorderRadius.circular(10.0), //<-- SEE HERE
                        ),
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: Color(0xffF8F8F8),
                        child: SizedBox(
                          width: 400,
                          height: 180,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Departure location: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        RidesInformation!.Destination
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Destination: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        RidesInformation.Departure_Location
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date of pick up: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        RidesInformation.Departure_Date
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time of pick up: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        RidesInformation.Departure_Time
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fees: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        RidesInformation.Ride_Fees.toString(),
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
                        )); //SizedBox

                  } else {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                  }

                  //By default, show a loading spinner.
                  return const CircularProgressIndicator(
                    value: 20,
                  );
                },
              )),
        ],
      ),

      /*  body: Padding(
        padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Rides>(
            future: futureRides,
            builder: (context, snapshot) => {
              if (snapshot.hasData) {
              var ridesInformation = snapshot.data;
              }
           },
          /*child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Color(0xffF8F8F8),
            child: SizedBox(
              width: 400,
              height: 180,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Departure location: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Destination: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Date of pick up: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Time of pick up: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Fees: ',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /*child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Departure location: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Destination: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //SizedBox
                  ],
                ), //Column
              ), //Padding
          */
            ), //SizedBox
          ),*/
        ),
      ), //Center
   */
    );
  }
}
