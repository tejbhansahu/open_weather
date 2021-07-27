import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_weather/src/Colors.dart';
import 'package:open_weather/src/providers/weatherProvider.dart';
import 'package:open_weather/src/screens/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(create: (_) => CurrentWeather()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: primaryColor
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}