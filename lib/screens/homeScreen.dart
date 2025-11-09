import 'package:flutter/material.dart';
import 'package:skycast/widgets/weatherDetailItem.dart';

import '../services/weatherService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String dummyWeatherCondition = "sunny";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
  final String cityName = "London";
  late Future<WeatherModel> _weatherFuture;
  @override
  void initState() {
    // TODO: implement initState
    _weatherFuture = WeatherService.getCurrentWeather(cityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getBackgroundGradient(HomeScreen.dummyWeatherCondition);
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
        child: SafeArea(
          // This will contain all the screen's main sections
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            // The Column will arrange the Top, Middle, and Bottom sections vertically
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Placeholder for Step 2: Top Section (City, Search, Date)
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Search Icon (for Phase 4)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white, size: 30),
                    onPressed: () {
                      // TODO: Implement city search functionality in Phase 4
                      print('Search pressed!');
                    },
                  ),
                ),

                // 2. City Name
                const Text(
                  'London, UK', // Dummy City Name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // 3. Current Date
                 Text(
                  'Tuesday, October 29', // Dummy Date
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),

                // Flexible space pushes the middle section up/down as needed
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. Weather Icon (using a placeholder for now)
                      const Icon(
                        Icons.wb_sunny_rounded, // Placeholder icon
                        color: Colors.white,
                        size: 120,
                      ),
                      const SizedBox(height: 10),

                      // 2. Big Temperature Text
                      const Text(
                        '32°C', // Dummy Temperature
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 96,
                          fontWeight: FontWeight.w300, // Thin font weight looks modern
                        ),
                      ),
                      const SizedBox(height: 5),

                      // 3. Weather Condition Text
                      Text(
                        HomeScreen.dummyWeatherCondition.toUpperCase(), // Using the dummy variable
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

                // Placeholder for Step 4: Bottom Section (Dashboard)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                // 💡 Add a semi-transparent background to visually group the data
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // The "glassmorphism" base color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Detail 1: Feels Like Temperature
                    WeatherDetailItem(
                      icon: Icons.thermostat_outlined,
                      label: 'Feels Like',
                      value: '35°C', // Dummy Data
                    ),

                    // Separator Line
                    const VerticalDivider(color: Colors.white54, width: 20, thickness: 1),

                    // Detail 2: Wind Speed
                    WeatherDetailItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '15 km/h', // Dummy Data
                    ),

                    // Separator Line
                    const VerticalDivider(color: Colors.white54, width: 20, thickness: 1),

                    // Detail 3: Humidity
                    WeatherDetailItem(
                      icon: Icons.opacity,
                      label: 'Humidity',
                      value: '65%', // Dummy Data
                    ),
                  ],
                ),
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
