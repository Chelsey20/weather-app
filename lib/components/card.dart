import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/fonts.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final String icon;
  final dynamic dataVal;
  final Color color;
  final Widget? widget;

  const WeatherCard({
    super.key,
    required this.title,
    required this.icon,
    this.dataVal,
    this.widget,
    this.color = const Color(0xFF091754),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'asset/svg/$icon.svg',
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              SizedBox(width: 4),
              Flexible(child: Text(title, style: myFonts.subtitle)),
            ],
          ),
          widget ?? Text('$dataVal', style: myFonts.normal),
        ],
      ),
    );
  }
}
