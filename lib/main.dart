import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service_json.dart';
import 'package:weather_app/utils/fonts.dart';
import 'package:weather_app/utils/format_code.dart';
import 'package:weather_app/xml_page.dart';
import 'components/card.dart';
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

class WeatherLoader extends StatelessWidget {
  final WeatherJsonService weatherService = WeatherJsonService();

  WeatherLoader({super.key});

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

class WeatherHome extends StatelessWidget {
  final WeatherJson weatherJson;

  const WeatherHome({super.key, required this.weatherJson});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'asset/images/background-image.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      /// title
                      Text(weatherJson.cityName, style: myFonts.title),
                      Text(
                        '${Format.degrees(weatherJson.temp)} °C | ${weatherJson.desc}',
                        style: myFonts.subtitle,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => XmlWeatherLoader(),
                            ),
                          );
                        },
                        child: Text('Click to View XML Integration'),
                      ),
                      SizedBox(height: 80),

                      /// main container
                      _buildBody(weatherJson),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(WeatherJson weather) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Opacity(
            opacity: 0.8,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1),
                  left: BorderSide(color: Colors.grey, width: 1),
                  right: BorderSide(color: Colors.grey, width: 1),
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
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

                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: WeatherCard(
                      title: 'Heat Index',
                      icon: 'thermostat',
                      dataVal: '${Format.degrees(weather.heatIndex)} °C',
                    ),
                  ),

                  Flexible(
                    child: Center(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          WeatherCard(
                            title: 'Humidity',
                            icon: 'thermostat',
                            dataVal: '${weather.humidity} %',
                          ),
                          WeatherCard(
                            title: 'Sunset',
                            icon: 'sunset',
                            dataVal: Format.sunDate(weather.sunset),
                          ),
                          WeatherCard(
                            title: 'Wind speed',
                            icon: 'wind',
                            dataVal: '${weather.windSpeed} m/s',
                          ),
                          WeatherCard(
                            title: weather.main,
                            icon: 'rain',
                            dataVal: '${weather.condition} %',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
