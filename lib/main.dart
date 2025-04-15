import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/utils/fonts.dart';
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
      home: Scaffold(
        backgroundColor: Color(0xFF29243c),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  /// title
                  Text('Manila', style: myFonts.title),
                  Text('19 Deg | Mostly clear', style: myFonts.subtitle),

                  SizedBox(height: 80),

                  /// main container
                  _buildBody(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBody() {
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
                  dataVal: '308.8',
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
                        dataVal: '308.8',
                      ),
                      _buildCard(
                        title: 'Sunset',
                        icon: 'sunrise',
                        dataVal: '308.8',
                      ),
                      _buildCard(
                        title: 'Wind speed',
                        icon: 'wind',
                        dataVal: '308.8',
                      ),
                      _buildCard(title: 'Rain', icon: 'rain', dataVal: '308.8'),
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
  required String dataVal,
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
        Text(dataVal, style: myFonts.normal),
      ],
    ),
  );
}
