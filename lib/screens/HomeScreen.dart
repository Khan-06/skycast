import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String dummyWeatherCondition = "Sunny";

  @override
  Widget build(BuildContext context) {
    List<Color> _getBackgroundGradient(String condition) {
      switch (condition.toLowerCase()) {
        case 'sunny':
        case 'clear':
          return [
            const Color(0xFFF7941D), // Deep Orange/Yellow
            const Color(0xFFFDC830), // Bright Yellow
          ];
        case 'clouds':
        case 'cloudy':
          return [
            const Color(0xFF5D6D7E), // Gray-Blue
            const Color(0xFF7A8D9F), // Lighter Gray-Blue
          ];
        case 'rain':
        case 'drizzle':
          return [
            const Color(0xFF4A6070), // Darker Blue-Gray
            const Color(0xFF678091), // Medium Blue-Gray
          ];
        case 'snow':
          return [
            const Color(0xFFB5CAD5), // Light Blue/Silver
            const Color(0xFFE6EBF0), // White/Very Light Gray
          ];
        case 'thunderstorm':
          return [
            const Color(0xFF2C3E50), // Dark Blue/Slate
            const Color(0xFF4A6070), // Darker Blue-Gray
          ];
        default:
          return [Colors.blue, Colors.lightBlueAccent];
      }
    }

    return Scaffold(body: Text("YOOOOO"));
  }
}
