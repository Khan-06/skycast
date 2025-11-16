import 'package:flutter/material.dart';

class WeatherDetails {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherDetails({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}

class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String weatherCondition; // The main condition (e.g., "Clear")
  final String iconCode;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCondition,
    required this.iconCode,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // OpenWeatherMap puts the weather condition details in a list named 'weather'.
    // We assume the first element (index 0) is the most relevant.
    final weatherList = json['weather'] as List;
    final weatherJson = weatherList.isNotEmpty ? weatherList[0] : {};

    // Helper function to safely extract and map the WeatherDetails data
    String getDetail(String key) => weatherJson[key] as String? ?? 'N/A';

    return WeatherModel(
      cityName: json['name'] as String,
      // We use (json['main']['temp'] as num).toDouble() to handle cases where
      // the API returns an integer instead of a double, preventing type errors.
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),

      // Extract the key strings from the nested 'weather' list
      weatherCondition: getDetail('main'),
      iconCode: getDetail('icon'),
    );
  }
}
