import 'package:weather_app/service/weather_service_json.dart';
import 'package:weather_app/service/weather_service_xml.dart';
import 'model/weather_json.dart';
import 'model/weather_xml.dart';
import 'utils/format_code.dart';

void main() async {
  await getWeather();
}

Future<void> getWeather() async {
  final weatherService = WeatherJsonService();
  final weather = await weatherService.fetchWeather();
  final format = Format();

  Format.degrees(456.899);
  String temp = (weather!.temp / 10).toStringAsFixed(2);
  String newTemp = Format.degrees(weather.temp);

  print(
    '${weather.cityName} temp:$newTemp desc: ${weather.desc} heat index: ${weather.heatIndex}',
  );
}
