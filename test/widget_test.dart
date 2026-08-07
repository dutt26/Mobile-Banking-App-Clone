import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_banking_app/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // MyApp does not include its own ProviderScope — that wrapper lives in
    // main.dart's runApp() call, so tests must add it explicitly here.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pump();

    // No specific text/widget assertion — this test only confirms the
    // widget tree builds and renders a first frame without throwing.
    // Add real assertions here once you know which widgets should appear,
    // e.g. expect(find.byType(Scaffold), findsWidgets);
  });
}
