class WeatherModel {
  final String cityName;
  final String date;
  final double temperature;
  final double precipitation;
  final double humidity;

  WeatherModel({
    required this.cityName,
    required this.date,
    required this.temperature,
    required this.precipitation,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      date: DateTime.now().toString(),
      temperature:
          (json['main']['temp'] as num).toDouble(), // Conversion en double
      precipitation: (json['rain'] != null
          ? (json['rain']['1h'] as num).toDouble()
          : 0.0), // Conversion en double
      humidity:
          (json['main']['humidity'] as num).toDouble(), // Conversion en double
    );
  }
}
