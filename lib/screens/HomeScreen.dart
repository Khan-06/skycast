import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String dummyWeatherCondition = "Sunny";

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

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getBackgroundGradient(dummyWeatherCondition);
    return Scaffold(
      body: Container(
        // 2. Apply the dynamic gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        // 3. Use a SafeArea to ensure content isn't under the status bar
        child: const SafeArea(
          // This will contain all the screen's main sections
          child: Padding(
            padding: EdgeInsets.all(20.0),
            // The Column will arrange the Top, Middle, and Bottom sections vertically
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Placeholder for Step 2: Top Section (City, Search, Date)
                Text(
                  'Top Section Placeholder',
                  style: TextStyle(color: Colors.white),
                ),

                // Flexible space pushes the middle section up/down as needed
                Expanded(
                  // Placeholder for Step 3: Middle Section (Temp, Icon, Description)
                  child: Center(
                    child: Text(
                      'Middle Section Placeholder',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),

                // Placeholder for Step 4: Bottom Section (Dashboard)
                Text(
                  'Bottom Section Placeholder',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
