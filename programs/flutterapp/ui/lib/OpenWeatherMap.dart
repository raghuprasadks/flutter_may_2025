import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String city = 'London';
  WeatherInfo? weatherInfo;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final apiKey = '384db1ce93218e20fd384d3016372238'; // Replace with your OpenWeatherMap API key
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final decodedData = json.decode(response.body);
        print("decoded data :: $decodedData");
        setState(() {
          weatherInfo = WeatherInfo.fromJson(decodedData);
          print("weatherinfo ## $weatherInfo");
        });
      } else {
        print('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter City',
                ),
                onChanged: (value) {
                  city = value;
                },
                onSubmitted: (value) {
                  _fetchWeather();
                },
              ),
            ),
            if (weatherInfo != null)
              Column(
                children: [
                  Text('City: ${weatherInfo!.name}'),
                  Text('Min Temp: ${weatherInfo!.tempMin}°C'),
                  Text('Max Temp: ${weatherInfo!.tempMax}°C'),
                  Text('Pressure: ${weatherInfo!.pressure} hPa'),
                ],
              )
            else
              const Text('Enter a city to see weather data.'),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo {
  final String name;
  final double tempMin;
  final double tempMax;
  final int pressure;

  WeatherInfo({
    required this.name,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      name: json['name'] ?? 'N/A',
      tempMin: json['main']['temp_min'].toDouble() ?? 0.0,
      tempMax: json['main']['temp_max'].toDouble() ?? 0.0,
      pressure: json['main']['pressure'] ?? 0,
    );
  }
}