// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:carpoolapp/screens/calculate.dart';
import 'package:carpoolapp/screens/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Render 2 widgets of Type ElevatedButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(const HomeScreen());
    expect(find.text('Carpool'), findsOneWidget);
  });
  // group('Group1', () {
  //   // testWidgets('Render 2 widgets of Type ElevatedButton',
  //   //     (WidgetTester tester) async {
  //   //   await tester.pumpWidget(ShareRideScreen());
  //   //   expect(find.byType(SingleChildScrollView), findsNWidgets(1));
  //   // });

  //   testWidgets('Render 4 widgets of Type ListTile',
  //       (WidgetTester tester) async {
  //     await tester.pumpWidget(const CalculatorPage());
  //     expect(find.byType(SingleChildScrollView),
  //         findsNWidgets(1)); // Expecting 4 ListTile widget on    Screen.
  //   });
  // });
}
