import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather.dart';

class WeatherService {
  //environment variables
  final apiKey = '873c26c3450412192bf6c76559e590a1';
  final id = '1701668';
  final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather?> fetchWeather() async {
    final url = '$baseUrl?id=$id&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    try {
      if(response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Weather.fromJson(data);
      } else {
        print('Failed to fetch JSON weather data: ${response.statusCode}');
        return null;
      }
    } catch (e){
      print(e);
      return null;
    }
  }
}