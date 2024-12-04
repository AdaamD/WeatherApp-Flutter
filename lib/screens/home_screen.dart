import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'weather_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weather;
  String _errorMessage = '';

  void _getWeather() async {
    WeatherService service = WeatherService();
    print(
        "Fetching weather for city: ${_controller.text}"); // Log pour déboguer
    try {
      var weatherData = await service.fetchWeather(_controller.text);
      print("Weather data retrieved successfully."); // Log pour déboguer
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherDetailScreen(weather: weatherData)),
      );
    } catch (e) {
      print("Error fetching weather: $e"); // Log pour déboguer
      setState(() {
        _errorMessage = 'Erreur lors de la récupération des données : $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50], // Couleur de fond douce
        ),
        padding: const EdgeInsets.all(16.0), // Padding autour du contenu
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Entrez le nom de la ville',
                border: const OutlineInputBorder(), // Bordure arrondie
                prefixIcon:
                    const Icon(Icons.location_city), // Icône d'emplacement
              ),
            ),
            const SizedBox(
                height: 16.0), // Espacement entre le champ et le bouton
            ElevatedButton(
              onPressed: _getWeather,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Couleur du bouton
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0), // Padding interne
                textStyle: const TextStyle(fontSize: 18), // Taille du texte
              ),
              child: const Text('Obtenir la météo'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_errorMessage,
                    style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
