import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service_xml.dart';
import 'package:weather_app/utils/fonts.dart';
import 'package:weather_app/utils/format_code.dart';
import 'components/card.dart';
import 'model/weather_xml.dart';

class XmlWeatherLoader extends StatelessWidget {
  const XmlWeatherLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherXml?>(
      future: weatherXmlService(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('waiting');
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Text('Has No Data || error');
        } else {
          final weather = snapshot.data!;
          return WeatherHome(weatherXml: weather);
        }
      },
    );
  }
}

class WeatherHome extends StatelessWidget {
  final WeatherXml weatherXml;
  const WeatherHome({super.key, required this.weatherXml});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFF274462),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                    color: Colors.black,
                  ),
                ),

                // title
                Text(weatherXml.cityName, style: myFonts.title),
                Text(
                  '${Format.degrees(weatherXml.temp)} °C | ${weatherXml.desc}',
                  style: myFonts.subtitle,
                ),
                SizedBox(height: 80),

                /// main container
                _buildBody(weatherXml),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(WeatherXml weather) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
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
                color: Color(0xFF0a2960),
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
                      color: Color(0xFF0a2960),
                    ),
                    WeatherCard(
                      title: 'Sunset',
                      icon: 'sunset',
                      dataVal: weather.sunset,
                      color: Color(0xFF0a2960),
                    ),
                    WeatherCard(
                      title: 'Wind speed',
                      icon: 'wind',
                      dataVal: '${weather.windSpeed} m/s',
                      color: Color(0xFF0a2960),
                    ),
                    WeatherCard(
                      title: ' Weather',
                      icon: 'rain',
                      dataVal: '${weather.condition} %',
                      color: Color(0xFF0a2960),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
