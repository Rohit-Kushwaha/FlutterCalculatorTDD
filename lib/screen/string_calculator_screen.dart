import 'package:flutter/material.dart';
import 'package:tdd/string_calculator.dart';

class StringCalculatorScreen extends StatefulWidget {
  const StringCalculatorScreen({super.key});

  @override
  State<StringCalculatorScreen> createState() => _StringCalculatorScreenState();
}

class _StringCalculatorScreenState extends State<StringCalculatorScreen> {
  final _controller = TextEditingController();
  final _calculator = StringCalculator();
  String _result = "";

  void _calculate() {
    try {
      final sum = _calculator.add(_controller.text);
      setState(() {
        _result = "Result: $sum";
      });
    } catch (e) {
      setState(() {
        _result = "Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("String Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter numbers (comma separated):"),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g. 1,2",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
