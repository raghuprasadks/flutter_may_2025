import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _checkEvenOdd() {
    final input = _controller.text;
    final number = int.tryParse(input);
    setState(() {
      if (number == null) {
        _result = 'Please enter a valid integer';
      } else if (number % 2 == 0) {
        _result = '$number is Even';
      } else {
        _result = '$number is Odd';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Even or Odd Checker')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter a number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkEvenOdd,
                  child: const Text('Check'),
                ),
                const SizedBox(height: 20),
                Text(
                  _result,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}