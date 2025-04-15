class Weather {
  final String cityName;
  final double temp;

  Weather({required this.cityName, required this.temp});

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
        cityName: data['name'],
        temp:(data['main']['temp'] as num).toDouble(),
    );
  }
}