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
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CurrentWeather(weather: weather),
              TodayWeather(forecasts: weather.forecasts),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  final WeatherModel weather;

  CurrentWeather({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xff00A1FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            weather.cityName,
            style: GoogleFonts.lato(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('dd/MM/yyyy - HH:mm')
                .format(DateTime.parse(weather.date)),
            style: GoogleFonts.lato(fontSize: 18, color: Colors.white70),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'http://openweathermap.org/img/w/${weather.icon}.png',
                height: 90,
                width: 90,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 20),
              Text(
                '${weather.temperature.round()}°C',
                style: GoogleFonts.lato(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            weather.description[0].toUpperCase() +
                weather.description.substring(1),
            style: GoogleFonts.lato(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherInfo(
                title: 'Précipitation',
                value: '${weather.precipitation} mm',
              ),
              WeatherInfo(
                title: 'Humidité',
                value: '${weather.humidity}%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final String title;
  final String value;

  WeatherInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.lato(fontSize: 16, color: Colors.white70),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}

class TodayWeather extends StatelessWidget {
  final List<DailyForecast> forecasts;

  TodayWeather({required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prévisions',
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forecasts.length,
              itemBuilder: (context, index) {
                final forecast = forecasts[index];
                return WeatherWidget(forecast: forecast);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final DailyForecast forecast;

  WeatherWidget({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${forecast.date.day}/${forecast.date.month}',
            style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
          ),
          Image.network(
            'http://openweathermap.org/img/w/${forecast.icon}.png',
            height: 40,
            width: 40,
          ),
          Text(
            '${forecast.temperature.round()}°C',
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            forecast.description[0].toUpperCase() +
                forecast.description.substring(1),
            style: GoogleFonts.lato(fontSize: 12, color: Colors.black54),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
