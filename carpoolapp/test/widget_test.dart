// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:carpoolapp/screens/calculate.dart';
// import 'package:carpoolapp/screens/home_screen.dart';
// import 'package:carpoolapp/screens/add_car_screen.dart';
//import 'package:carpoolapp/screens/add_car_screen.dart';
import 'package:carpoolapp/screens/share_ride.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:carpoolapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Startup Test', () {
    testWidgets('Find location and test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpWidget(MaterialApp(home: ShareRideScreen()));
      //expect(find.byIcon(Icons.money), findsNWidgets(1));
      // await tester.pumpAndSettle();
      //await tester.drag(find.byIcon(Icons.money), const Offset(0, 0));
      /**
      * Text Field Find By Keys
      * */
      var feesTextField = find.byKey(const Key("fees_text_field"));
      var departureTextField = find.byKey(const Key("departure_text_field"));
      var destinationTextField = find.byKey(const Key("destination_text_field"));
      var timeTextField = find.byKey(const Key("time_text_field"));
      var dateTextField = find.byKey(const Key("date_text_field"));
      await tester.tap(feesTextField);
      await tester.enterText(feesTextField, '21');
      await Future.delayed(const Duration(seconds: 4));
      expect(find.text('21'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      await tester.tap(departureTextField);
      await tester.enterText(departureTextField, 'Tunis');
      await Future.delayed(const Duration(seconds: 4));
      //expect(find.text('Tunis, Tunisia'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));
      /**Trying to find the button at the end of the widget to drag! NOT WORKING YET BUT TEST PASS!!**/
      await tester.drag(find.byType(ElevatedButton), const Offset(500.0, 700.0));
      await tester.pump(const Duration(milliseconds: 500));
    });
  });
}
