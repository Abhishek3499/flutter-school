// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:login_page/main.dart';

void main() {
  testWidgets('Login page renders, shows tagline and Gmail social button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Wait for animations to settle
    await tester.pumpAndSettle();

    // Main login action should be present
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Tagline should be visible
    expect(find.text('Start Your Coding Journey Today'), findsOneWidget);

    // Gmail social button should be present
    expect(find.text('Login with Gmail'), findsOneWidget);

    // Tap Gmail button and verify SnackBar appears
    await tester.tap(find.text('Login with Gmail'));
    await tester.pump();
    expect(find.text('Gmail sign-in (demo)'), findsOneWidget);
  });
}
