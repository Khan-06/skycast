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
