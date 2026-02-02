import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weatherModel.dart';
import '../keys/key.dart';

class WeatherService {
  static const String _baseURL = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = openWeatherAPIKey;

  // Corrected implementation of the async function
  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    final uri = Uri.parse(
      '$_baseURL/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric',
    );

    final response = await http.get(uri); // Await the network call

    // For debugging, keep the print, but remove it later for production build
    print('WeatherService response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

      // FIX: Ensure this line returns the result
      return WeatherModel.fromJson(jsonMap);
    } else {
      throw Exception(
          'Failed to load weather by location: ${response.statusCode}');
    }
  }
}