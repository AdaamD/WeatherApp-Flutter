import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'weather_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _errorMessage = '';

  void _getWeather() async {
    WeatherService service = WeatherService();
    try {
      var weatherData = await service.fetchWeather(_controller.text);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherDetailScreen(weather: weatherData)),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors de la récupération des données : $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Météo',
                style: GoogleFonts.lato(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00A1FF),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _controller,
                style: GoogleFonts.lato(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Entrez le nom de la ville',
                  labelStyle: GoogleFonts.lato(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xff00A1FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xff00A1FF), width: 2),
                  ),
                  prefixIcon:
                      Icon(Icons.location_city, color: Color(0xff00A1FF)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getWeather,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00A1FF),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Obtenir la météo',
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: GoogleFonts.lato(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
