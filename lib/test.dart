import 'package:weather_app/service/weather_service.dart';
import 'model/weather.dart';

void main() async {
  await getWeather();
}

Future<void> getWeather() async {
  final weatherService = WeatherService();
  final weather = await weatherService.fetchWeather();

  print(
    '${weather?.cityName} temp:${weather?.temp} desc: ${weather?.desc} heat index: ${weather?.heatIndex}',
  );
}
