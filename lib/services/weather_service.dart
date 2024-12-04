import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$OPENWEATHER_API_KEY&units=metric'));

      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        return WeatherModel.fromJson(weatherData);
      } else {
        throw Exception(
            'Failed to load weather data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      throw Exception('Failed to load weather data');
    }
  }
}
