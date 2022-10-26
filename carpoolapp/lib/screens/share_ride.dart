import 'package:flutter/material.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:carpoolapp/screens/dialog_screen.dart';
import 'package:carpoolapp/screens/ride_screen.dart';

void main() {
  runApp(ShareRideScreen());
}

class ShareRideScreen extends StatefulWidget {
  @override
  State<ShareRideScreen> createState() => _ShareRideScreenState();
}

class _ShareRideScreenState extends State<ShareRideScreen> {
  String selectedValue = "USA";
  String selectedFromWhere = "USA";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsFromWhere {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Share ride availability',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'From where?',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Color(0xFF008CFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '',
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'To where?',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Color(0xFF008CFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '',
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What time?',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Color(0xFF008CFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '',
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What date ?',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Color(0xFF008CFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '',
                    )),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          child: Text("Confirm"),
                          onPressed: () {
                            print('Button Avaible rides pressed ...');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF008CFF),
                            onPrimary: Colors.white,
                            fixedSize: Size(130, 40),
                            textStyle:
                                TextStyle(fontFamily: 'DM Sans', fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Deny"),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFEA3939),
                            onPrimary: Colors.white,
                            fixedSize: Size(130, 40),
                            textStyle:
                                TextStyle(fontFamily: 'DM Sans', fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
