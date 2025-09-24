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

    testWidgets('calculates sum of one number', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), "5");
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 5"), findsOneWidget);
    });

    testWidgets('calculates sum of two numbers', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), "4,6");
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 10"), findsOneWidget);
    });

    //** Not Needed */
    // testWidgets('shows error for more than two numbers',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(const MyApp());

    //   await tester.enterText(find.byType(TextField), "1,2,3");
    //   await tester.tap(find.text("Calculate"));
    //   await tester.pump();

    //   expect(find.textContaining("Error:"), findsOneWidget);
    // });

    testWidgets('calculates sum of many numbers', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), "1,2,3,4,5");
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 15"), findsOneWidget);
    });

    testWidgets('calculates sum with custom delimiter',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '//;\n1;2');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 3"), findsOneWidget);
    });

    testWidgets('calculates sum with another custom delimiter',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '//|\n4|5|6');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 15"), findsOneWidget);
    });

    testWidgets('shows error for negative numbers',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '1,-2,3');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.textContaining("Negatives not allowed: -2"), findsOneWidget);
    });

    testWidgets('ignores numbers greater than 1000',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '2,1001');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 2"), findsOneWidget);
    });

    testWidgets('calculates sum with long delimiter',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '//[***]\n1***2***3');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 6"), findsOneWidget);
    });

    testWidgets('calculates sum with multiple delimiters',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField), '//[*][%]\n1*2%3');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 6"), findsOneWidget);
    });

    testWidgets('calculates sum with multiple multi-character delimiters',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Multiple multi-character delimiters: "**" and "%%"
      await tester.enterText(find.byType(TextField), '//[**][%%]\n1**2%%3');
      await tester.tap(find.text("Calculate"));
      await tester.pump();

      expect(find.text("Result: 6"), findsOneWidget);
    });
  });
}
