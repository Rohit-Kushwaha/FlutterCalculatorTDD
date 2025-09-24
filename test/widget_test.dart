// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tdd/main.dart';

void main() {
  group('StringCalculatorScreen UI Tests', () {
    testWidgets('renders input, button and result text',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find widgets
      expect(find.text("Enter numbers (comma separated):"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text("Calculate"), findsOneWidget);
    });

    testWidgets('shows 0 for empty input', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Tap button without entering anything
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 0"), findsOneWidget);
    });
  });
}
