class Weather {
  final String cityName;
  final double temp;
  final double heatIndex;
  final String desc;

  Weather({
    required this.cityName,
    required this.temp,
    required this.heatIndex,
    required this.desc
  });

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
        cityName: data['name'],
        temp:(data['main']['temp'] as num).toDouble(),
        desc: data['weather']['description'],
        heatIndex: (data['main']['feels_like'] as num).toDouble(),
    );
  }
}