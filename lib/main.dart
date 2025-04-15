import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service.dart';
import 'model/weather.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //create instance
  final weatherService = WeatherService();
  final weather = await weatherService.fetchWeather();

  runApp(MyApp(weather: weather));
}

class MyApp extends StatelessWidget {
  final Weather? weather;

  const MyApp({super.key, required this.weather});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Weather Info')),
        body: Center(
          child: Text(
            'City: ${weather!.cityName}'
          ),
        )
      ),
    );
  }
}
