import 'package:carpoolapp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'add_car_screen.dart';
import 'car_information_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart' show GButton, GNav;

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final Screens = [
    const WelcomeScreen(),
    AddCarScreen(),
    const CarInformationScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Screens[currentIndex],
        // body: TextField(
        //   controller: _controller,
        //   decoration: InputDecoration(
        //       border: OutlineInputBorder(), labelText: "Enter text"),
        // ),
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
