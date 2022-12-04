import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/share_ride.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
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
                    onPressed: () {
                      print('Button Available rides pressed ...');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF37A33B),
                      onPrimary: Colors.white,
                      fixedSize: const Size(130, 40),
                      textStyle:
                          const TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                    ),
                    child: const Text("Available rides"),
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
                      side:
                          const BorderSide(color: Color(0xFF008CFF), width: 3),
                      primary: const Color(0xFFF8F8F8),
                      onPrimary: Colors.black,
                      fixedSize: const Size(130, 40),
                      textStyle:
                          const TextStyle(fontFamily: 'DM Sans', fontSize: 13),
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
                Expanded(
                  child: Padding(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
