import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/utils/fonts.dart';
import 'model/weather.dart';

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

class WeatherLoader extends StatelessWidget {
  final WeatherService weatherService = WeatherService();

  WeatherLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather?>(
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
          return WeatherHome(weather: weather); // your home UI
        }
      },
    );
  }
}

class WeatherHome extends StatelessWidget {
  final Weather weather;

  const WeatherHome({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        backgroundColor: Color(0xFF29243c),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  /// title
                  Text(weather.cityName, style: myFonts.title),
                  Text(
                    '${weather.temp} °C | ${weather.desc}',
                    style: myFonts.subtitle,
                  ),

                  SizedBox(height: 80),

                  /// main container
                  _buildBody(weather),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(Weather weather) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF3a275e),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          /// title bar
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            child: Text('Today\'s Forecast', style: myFonts.subtitle),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _buildCard(
                  title: 'Heat Index',
                  icon: 'thermostat',
                  dataVal: weather.heatIndex,
                ),

                SizedBox(height: 20),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      _buildCard(
                        title: 'Humidity',
                        icon: 'thermostat',
                        dataVal: weather.humidity,
                      ),
                      _buildCard(
                        title: 'Sunset',
                        icon: 'sunset',
                        dataVal: weather.sunset,
                      ),
                      _buildCard(
                        title: 'Wind speed',
                        icon: 'wind',
                        dataVal: weather.windSpeed,
                      ),
                      _buildCard(title: 'Rain', icon: 'rain', dataVal: 308.8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCard({
  required String title,
  required String icon,
  required var dataVal,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 0.5),
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF261d3a),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset('asset/svg/$icon.svg', height: 30, width: 30),
            SizedBox(width: 4),
            Flexible(child: Text(title, style: myFonts.subtitle)),
          ],
        ),
        Text('$dataVal', style: myFonts.normal),
      ],
    ),
  );
}
