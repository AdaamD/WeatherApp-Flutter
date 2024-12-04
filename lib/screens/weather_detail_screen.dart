import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_model.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherModel weather;

  WeatherDetailScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails Météo'), // Titre de l'AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/white_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  weather.cityName,
                  style: GoogleFonts.lato(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  weather.date,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${weather.temperature} °C',
                  style: GoogleFonts.lato(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Précipitation : ${weather.precipitation} mm',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Humidité : ${weather.humidity} %',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
