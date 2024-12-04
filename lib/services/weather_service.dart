import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart'; // Importez le fichier de configuration
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$OPENWEATHER_API_KEY&units=metric'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
