import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service_json.dart';
import 'package:weather_app/weather_home.dart';
import 'model/weather_json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WeatherLoader());
  }
}

class WeatherLoader extends StatefulWidget {
  const WeatherLoader({super.key});

  @override
  State<WeatherLoader> createState() => _WeatherLoaderState();
}

class _WeatherLoaderState extends State<WeatherLoader> {
  final WeatherJsonService weatherService = WeatherJsonService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherJson?>(
      future: weatherService.fetchWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Failed to load weather')),
          );
        } else {
          final weather = snapshot.data!;
          return WeatherHome(weatherJson: weather); // your home UI
        }
      },
    );
  }
}
