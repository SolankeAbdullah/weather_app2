import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';

class WeatherApiService {
  static const apiKey = '8f035c6fe1faca8bd5880f46087db345';
  static const baseUrl = 'http://api.openweathermap.org/';

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
