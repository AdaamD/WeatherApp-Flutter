class WeatherModel {
  final String cityName;
  final List<DailyForecast> forecasts;
  final String date;
  final double temperature;
  final double precipitation;
  final double humidity;
  final String icon; // Ajout de l'icône
  final String description; // Ajout de la description

  WeatherModel({
    required this.cityName,
    required this.forecasts,
    required this.date,
    required this.temperature,
    required this.precipitation,
    required this.humidity,
    required this.icon,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<DailyForecast> forecasts = (json['list'] as List)
        .where((item) => item['dt_txt'].contains('12:00:00'))
        .map((item) => DailyForecast.fromJson(item))
        .toList();

    return WeatherModel(
      cityName: json['city']['name'],
      forecasts: forecasts,
      date: DateTime.now().toString(),
      temperature: json['list'][0]['main']['temp'].toDouble(),
      precipitation: json['list'][0]['rain']?['3h'] ?? 0.0,
      humidity: json['list'][0]['main']['humidity'].toDouble(),
      icon: json['list'][0]['weather'][0]['icon'], // Ajout de l'icône
      description: json['list'][0]['weather'][0]
          ['description'], // Ajout de la description
    );
  }
}

class DailyForecast {
  final DateTime date;
  final double temperature;
  final String description;
  final String icon;

  DailyForecast({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
