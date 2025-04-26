import 'package:xml/xml.dart';

class WeatherXml {
  final String cityName;
  final double temp;
  final String desc;
  final double heatIndex;
  final int humidity;
  final String sunset;
  final String main;
  final double windSpeed;
  final String condition;

  WeatherXml({
    required this.cityName,
    required this.temp,
    required this.desc,
    required this.heatIndex,
    required this.humidity,
    required this.sunset,
    required this.main,
    required this.windSpeed,
    required this.condition,
  });

  factory WeatherXml.fromXml(XmlDocument data) {
    return WeatherXml(
      cityName: data.findAllElements('city').first.getAttribute('name') ?? '',
      temp: double.parse(
        data.findAllElements('temperature').first.getAttribute('value') ?? '0',
      ),
      desc: data.findAllElements('weather').first.getAttribute('value') ?? '',
      heatIndex: double.parse(
        data.findAllElements('feels_like').first.getAttribute('value') ?? '0',
      ),
      humidity: int.parse(
        data.findAllElements('humidity').first.getAttribute('value') ?? '0',
      ),
      sunset: data.findAllElements('sun').first.getAttribute('set') ?? '',
      main: data.findAllElements('clouds').first.getAttribute('name') ?? '',
      windSpeed: double.parse(
        data.findAllElements('speed').first.getAttribute('value') ?? '0',
      ),
      condition:
          data.findAllElements('clouds').first.getAttribute('name') ?? '',
    );
  }
}
