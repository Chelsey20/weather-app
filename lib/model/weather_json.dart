class WeatherJson {
  final String cityName;
  final double temp;
  final String desc;
  final double heatIndex;
  final int humidity;
  final int sunset;
  final String main;
  final double windSpeed;
  final int condition;

  WeatherJson({
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

  factory WeatherJson.fromJson(Map<String, dynamic> data) {
    return WeatherJson(
      cityName: data['name'],
      temp: (data['main']['temp'] as num).toDouble(),
      desc: data['weather'][0]['description'],
      heatIndex: (data['main']['feels_like'] as num).toDouble(),
      humidity: data['main']['humidity'],
      sunset: data['sys']['sunset'],
      main: data['weather'][0]['main'],
      windSpeed: data['wind']['speed'],
      condition: data['clouds']['all'],
    );
  }
}
