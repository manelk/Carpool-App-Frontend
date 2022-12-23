import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/ride_confirmed_screen.dart';
import 'package:flutter/material.dart';

import '../apis/car_api.dart';
import '../apis/rides_api.dart';
import '../models/car.dart';
import '../models/rides.dart';

class ConfirmRideScreen extends StatefulWidget {
  final String idCar;
  const ConfirmRideScreen({Key? key, required this.idCar}) : super(key: key);

  @override
  State<ConfirmRideScreen> createState() => _ConfirmRideScreenState();
}

class _ConfirmRideScreenState extends State<ConfirmRideScreen> {
  Future<List<Rides>>? ridesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.idCar);
    ridesFuture = RidesApi.getRideById(widget.idCar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Check ride',
          style: TextStyle(color: Colors.black),
        ),
        leadingWidth: 100,
        backgroundColor: Color.fromRGBO(248, 248, 248, 1),
        automaticallyImplyLeading: false,
        leading: ElevatedButton.icon(
          onPressed: ()  {
            Navigator.pop(context);
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
          if (snapshot.hasData && snapshot.data!.length > 0) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // Future<Car>? carFuture;
                // carFuture =
                //     CarApi.getCarById(snapshot.data![index].carId.toString());
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.96,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x49000000),
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 8, 8, 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1626806592005-7e371149356e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.9,
                                          height: 220,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 12, 16, 8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'Car brand: Ford',
                                                  style: TextStyle(fontSize: 17),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    'Car color: Black',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    'Energy type: Electric',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 4,
                                      thickness: 1,
                                      //   color: FlutterFlowTheme.of(context).primaryBackground,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Price : ' +
                                                snapshot.data![index].Ride_Fees
                                                    .toString() +
                                                "TND",
                                            style: TextStyle(fontSize: 20),
                                            //   style: FlutterFlowTheme.of(context).subtitle2,
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(50),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RideConfirmedWidget(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  primary: Color(0xFF008CFF),
                                  onPrimary: Colors.white,
                                  fixedSize: Size(150, 50),
                                  textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                                ),
                                child: const Text("Confirm ride"),
                              ),

                            ),
                           ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
