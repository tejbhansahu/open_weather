class API {
  // Base Url for all APIs
  static const baseUrl = "http://api.openweathermap.org";

  //Weather APIs
  static String getWeatherData(String city) => '$baseUrl/data/2.5/weather?q=$city&appid=ea97e52c3dd933f4e06a02012713596a';

}