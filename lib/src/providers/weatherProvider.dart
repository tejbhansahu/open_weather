import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_weather/src/api/api.dart';
import 'package:open_weather/src/models/model_weather.dart';

abstract class WeatherProvider extends ChangeNotifier{
  Weather? get weather;
  Future<Response> saveWeather(BuildContext context, String city);
}

class CurrentWeather implements WeatherProvider{

  Dio _dio = Dio();
  Weather? _weather;

  @override
  Weather? get weather => _weather;

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  Future<Response> saveWeather(BuildContext context, String city) async {
    try {
      var response = await _dio.post(
        API.getWeatherData(city),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200){
        _weather = Weather.fromJson(response.data);
        print(_weather);
      }
      notifyListeners();
      return response;
    } catch (e) {
      throw (e);
    }
  }

}