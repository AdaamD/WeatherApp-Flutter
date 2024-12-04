import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherModel weather;

  WeatherDetailScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo pour ${weather.cityName}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/white_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        DateFormat('dd/MM/yyyy - HH:mm')
                            .format(DateTime.parse(weather.date)),
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
            Container(
              height: 150, // Augmentation de la hauteur
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weather.forecasts.length,
                itemBuilder: (context, index) {
                  final forecast = weather.forecasts[index];
                  return Card(
                    child: Container(
                      width: 120, // Augmentation de la largeur
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${forecast.date.day}/${forecast.date.month}',
                            style: GoogleFonts.lato(fontSize: 16),
                          ),
                          Image.network(
                            'http://openweathermap.org/img/w/${forecast.icon}.png',
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            '${forecast.temperature.round()}°C',
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            forecast.description,
                            style: GoogleFonts.lato(fontSize: 12),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
