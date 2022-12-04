import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorPage());
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              ListTile(
                title: Text("Addition"),
                leading: Icon(Icons.add),
              ),
              ListTile(
                title: Text("Subtraction"),
                leading: Icon(Icons.minimize),
              ),
              ListTile(
                title: Text("Multiplication"),
                leading: Icon(Icons.cancel_outlined),
              ),
              ListTile(
                title: Text("Division"),
                leading: Icon(Icons.architecture),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
