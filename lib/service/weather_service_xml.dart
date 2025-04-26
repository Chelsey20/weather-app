import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_xml.dart';
import 'package:xml/xml.dart';

Future<WeatherXml?> weatherXmlService() async {
  final apiKey = '873c26c3450412192bf6c76559e590a1';
  final id = '1701668';
  final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final url = '$baseUrl?id=$id&appid=$apiKey&mode=xml';
  final emptyData = WeatherXml(
    cityName: 'Hello',
    temp: 0.9,
    heatIndex: 0.0,
    desc: '',
    humidity: 0,
    sunset: '0',
    main: '',
    windSpeed: 0.0,
    condition: '',
  );

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final document = XmlDocument.parse(response.body);
    print(document.findAllElements('city').first.getAttribute('name'));
    return WeatherXml.fromXml(document);
  } else {
    print('Failed: ${response.statusCode}');
    return emptyData;
  }
}

void main() async {
  await weatherXmlService();
}
