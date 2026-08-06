import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 
// TODO: replace with the actual import for your app's root widget,
// e.g. import 'package:mobile_banking_app_clone/main.dart';
 
void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // Minimal placeholder test so `flutter test` has something to run.
    // Replace MaterialApp/Scaffold below with your actual app widget,
    // e.g.: await tester.pumpWidget(const MyApp());
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('lib/main.dart)')),
        ),
      ),
    );
 
    expect(find.text('Placeholder'), findsOneWidget);
  });
}
