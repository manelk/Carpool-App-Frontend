import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/add_car_screen.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F8F8),
        automaticallyImplyLeading: false,
        title: const Text(
          'Carpool',
          style: TextStyle(color: Colors.black),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // What are you looking for today?
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      child: Text("Avaible rides"),
                      onPressed: () {
                        print('Button Avaible rides pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF37A33B),
                        onPrimary: Colors.white,
                        fixedSize: Size(130, 40),
                        textStyle:
                            TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                      ),
                    ),
                    ElevatedButton(
                      child: Text("Publish a ride"),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCarScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF008CFF), width: 3),
                        primary: Color(0xFFF8F8F8),
                        onPrimary: Colors.black,
                        fixedSize: Size(130, 40),
                        textStyle:
                            TextStyle(fontFamily: 'DM Sans', fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              // Row that contains the sentence "Available Rides"
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
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
      ),
    );
  }
}
