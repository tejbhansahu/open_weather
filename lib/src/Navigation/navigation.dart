import 'package:flutter/material.dart';
import 'package:open_weather/src/screens/showWeather.dart';

class Navigation{
  Navigation._();

  static moveToWeatherScreen(BuildContext context, String city) {
    Navigator.of(context).push((MaterialPageRoute(builder: (context) => ShowWeather(city))));
  }
}