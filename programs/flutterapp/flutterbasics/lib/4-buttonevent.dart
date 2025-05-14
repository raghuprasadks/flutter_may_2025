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
  Color _backgroundColor = Colors.white;

  void _changeColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello World',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.yellow,
                ),
              ),
              Text(
                'Welcome to Flutter!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _changeColor(Colors.red),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Red'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeColor(Colors.green),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Green'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeColor(Colors.blue),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Blue'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
