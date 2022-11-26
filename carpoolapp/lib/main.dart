import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:carpoolapp/screens/add_car_screen.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/ride_screen.dart';
import 'package:carpoolapp/screens/car_information_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const CarpoolApp());
}

class CarpoolApp extends StatefulWidget {
  const CarpoolApp({Key? key}) : super(key: key);
  @override
  State<CarpoolApp> createState() => _CarpoolAppState();
}

class _CarpoolAppState extends State<CarpoolApp> {
  int currentIndex = 0;
  final Screens = [HomeScreen(), AddCarScreen(), CarInformationScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Screens[currentIndex],
        bottomNavigationBar: Container(
          color: Color(0xffF8F8F8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
              backgroundColor: Color(0xffF8F8F8),
              color: Colors.black,
              activeColor: Color(0xFF008CFF),
              tabBackgroundColor: Colors.grey.shade200,
              padding: EdgeInsets.all(16),
              gap: 20,
              onTabChange: (index) => setState(() => currentIndex = index),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.car_rental,
                  text: "Car",
                ),
                GButton(
                  icon: Icons.account_box,
                  text: "Account",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/****
 * 
 *  bottomNavigationBar: Container(
  color: Color(0xffF8F8F8),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    child: GNav(
      backgroundColor: Color(0xffF8F8F8),
      color: Colors.black,
      activeColor: Color(0xFF008CFF),
      tabBackgroundColor: Colors.grey.shade200,
      padding: EdgeInsets.all(16),
      gap: 20,
      onTabChange: (index) {
        print(index);
      },
      tabs: [
        GButton(
          icon: Icons.home,
          text: "Home",
        ),
        GButton(
          icon: Icons.car_rental,
          text: "Car",
        ),
        GButton(
          icon: Icons.account_box,
          text: "Account",
        ),
      ],
    ),
  ),
),
      
 */