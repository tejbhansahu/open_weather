import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_weather/src/Colors.dart';
import 'package:open_weather/src/models/model_weather.dart';
import 'package:open_weather/src/providers/weatherProvider.dart';
import 'package:open_weather/src/widgets/data_viz.dart';

class ShowWeather extends StatefulWidget {
  final String city;
  ShowWeather(this.city);

  @override
  _ShowWeatherState createState() => _ShowWeatherState();
}

class _ShowWeatherState extends State<ShowWeather> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    Response res = await Provider.of<WeatherProvider>(context, listen: false,).saveWeather(context, widget.city.toLowerCase());
    if(res.statusCode == 200)
      setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<WeatherProvider>(context, listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.city.toUpperCase()),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, value, child) {
          Weather? weather = value.weather;
          if (weather == null) {
            return Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(primaryColor),));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network("http://openweathermap.org/img/wn/${weather.weather.first.icon}@2x.png", height: 60.0, width: 60.0,),
                        Container(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(
                            weather.weather.first.main,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      weather.weather.first.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      k2c(weather.main.temp.toString()),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Feels Like - ${k2c(weather.main.feelsLike.toString())}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.7,
                    height: 35.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor,
                        ),
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Center(
                      child: Text(
                        "Longitude: ${weather.coord.lon}  Latitude: ${weather.coord.lat}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    width: size.width * 0.95,
                    height: 80.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Max Temp: ${k2c(weather.main.tempMax.toString())}",
                                style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold,),
                              ),
                              Text(
                                  "Humidity: ${weather.main.humidity}%",
                                style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Visibility: ${weather.visibility / 1000} km",
                                style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold,),
                              ),
                              Text(
                                  "Pressure: ${weather.main.pressure.toStringAsFixed(1)}hPa",
                                style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                                height: size.width * 0.35,
                                width: size.width * 0.35,
                                child: DataViz("${weather.wind.speed}", primaryColor, "s")
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Wind Speed (m/s)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: size.width * 0.035
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                height: size.width * 0.35,
                                width: size.width * 0.35,
                                child: DataViz("${weather.wind.deg}", primaryColor, "d")
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Direction (°)",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: size.width * 0.035
                                ),
                              ),
                            )
                          ],
                        ),
                      ]
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "PoppinsMedium",
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      duration: Duration(seconds: 2),
    ));
  }

  String k2c(String f) {
    return "${(double.parse(f) - 273.15).toStringAsFixed(0)} °C";
  }

}
