import 'package:carpoolapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'screens/home_screen.dart';
import 'package:carpoolapp/screens/add_car_screen.dart';
import 'package:carpoolapp/screens/home_screen.dart';
// import 'package:carpoolapp/screens/ride_screen.dart';
import 'package:carpoolapp/screens/car_information_screen.dart';
// import 'package:carpoolapp/screens/autocomplete.dart';
import 'package:google_nav_bar/google_nav_bar.dart' show GButton, GNav;

void main() {
  runApp(const CarpoolApp());
}

class CarpoolApp extends StatefulWidget {
  const CarpoolApp({Key? key}) : super(key: key);
  @override
  State<CarpoolApp> createState() => _CarpoolAppState();
}


class _CarpoolAppState extends State<CarpoolApp> {

  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  final Screens = [
    const HomeScreen(),
    AddCarScreen(),
    const CarInformationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller = TextEditingController();
    return GetMaterialApp(
     debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
