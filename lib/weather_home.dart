import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/components/gradient_slider.dart';
import 'package:weather_app/utils/fonts.dart';
import 'package:weather_app/utils/format_code.dart';
import 'package:weather_app/utils/level_indicators.dart';
import 'components/card.dart';
import 'model/weather_json.dart';

class WeatherHome extends StatefulWidget {
  final WeatherJson weatherJson;

  const WeatherHome({super.key, required this.weatherJson});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late double humidity;

  @override
  void initState() {
    super.initState();
    humidity = widget.weatherJson.humidity.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundImage(context),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Image.asset(
      'asset/images/background-image.jpg',
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          _buildWeatherInfo(),
          const SizedBox(height: 80),
          _buildForecast(),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Column(
      children: [
        Text(widget.weatherJson.cityName, style: myFonts.title),
        Text(
          '${Format.degrees(widget.weatherJson.temp)} °C | ${widget.weatherJson.desc}',
          style: myFonts.subtitle,
        ),
      ],
    );
  }

  Widget _buildForecast() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Opacity(
              opacity: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    _buildTitleBar(),

                    SizedBox(height: 40),

                    _buildHeatIndexCard(),

                    SizedBox(height: 30),

                    _buildWeatherCards(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
      ),
      child: Text('Today\'s Forecast', style: myFonts.subtitle),
    );
  }

  Widget _buildHeatIndexCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: WeatherCard(
        title: 'Heat Index',
        icon: 'thermostat',
        widget: _buildHeatIndexWidget(),
      ),
    );
  }

  Widget _buildWeatherCards() {
    return Flexible(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          WeatherCard(
            title: 'Humidity',
            icon: 'thermostat',
            widget: _buildHumidityWidget(),
          ),
          WeatherCard(
            title: 'Sunset',
            icon: 'sunset',
            widget: _buildSunWidget(),
          ),
          WeatherCard(
            title: 'Wind speed',
            icon: 'wind',
            dataVal: '${widget.weatherJson.windSpeed} m/s',
          ),
          WeatherCard(
            title: widget.weatherJson.main,
            icon: 'rain',
            dataVal: '${widget.weatherJson.condition} %',
          ),
        ],
      ),
    );
  }

  Widget _buildHeatIndexWidget() {
    return Column(
      children: [
        Text(
          '${Format.degrees(widget.weatherJson.heatIndex)} °C',
          style: myFonts.title,
        ),
        Text(
          labelHeatIndex(widget.weatherJson.heatIndex),
          style: myFonts.normal,
        ),
      ],
    );
  }

  Widget _buildHumidityWidget() {
    double humidity = widget.weatherJson.humidity.toDouble();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$humidity %',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                humidityLabel(humidity),
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          GradientProgressBar(percentage: humidity),
        ],
      ),
    );
  }

  Widget _buildSunWidget() {
    return Column(
      children: [
        Text(
          Format.sunDate(widget.weatherJson.sunset),
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
