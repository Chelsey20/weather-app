import 'package:weather_app/service/weather_service.dart';
import 'model/weather.dart';
import 'utils/format_code.dart';

void main() async {
  await getWeather();
}

Future<void> getWeather() async {
  final weatherService = WeatherService();
  final weather = await weatherService.fetchWeather();
  final format = Format();

  format.degrees(456.899);
  String temp = (weather!.temp / 10).toStringAsFixed(2);
  String newTemp = format.degrees(weather.temp);

  print(
    '${weather.cityName} temp:$newTemp desc: ${weather.desc} heat index: ${weather.heatIndex}',
  );
}
