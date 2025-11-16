import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skycast/widgets/weatherDetailItem.dart';

import '../models/weatherModel.dart';
import '../services/weatherService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String dummyWeatherCondition = "sunny";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();

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

  final String cityName = "Pakistan";
  late Future<WeatherModel> _weatherFuture;
  @override
  void initState() {
    // TODO: implement initState
    _weatherFuture = _weatherService.getCurrentWeather(cityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getBackgroundGradient(
      HomeScreen.dummyWeatherCondition,
    );
    return FutureBuilder<WeatherModel>(
      future: _weatherFuture,
      // The builder function runs every time the Future's state changes
      builder: (context, snapshot) {
        // --- A. Loading State (ConnectionState.waiting) ---
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner on a neutral gradient background
          final loadingGradient = _getBackgroundGradient(
            'clear',
          ); // Use a generic color for loading
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: loadingGradient,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          );
        }
        // --- B. Error State (snapshot.hasError) ---
        else if (snapshot.hasError) {
          // If the API call failed (e.g., wrong city name, bad API key)
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Failed to fetch weather data. Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
              ),
            ),
          );
        }
        // --- C. Success State (snapshot.hasData) ---
        else if (snapshot.hasData) {
          // Data is successfully retrieved!
          final weatherData = snapshot.data!;

          // Use the live weather condition to choose the background gradient
          final gradientColors = _getBackgroundGradient(
            weatherData.weatherCondition,
          );

          // Return your entire static UI, but populated with live data
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors, // DYNAMIC BACKGROUND
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TOP SECTION (DYNAMIC)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                /* TODO: Phase 4 Search */
                              },
                            ),
                          ),
                          // City Name
                          Text(
                            weatherData.cityName, // LIVE DATA
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Current Date (You will need to import 'package:intl/intl.dart' for DateFormat)
                          Text(
                            DateFormat('EEEE, MMMM d').format(DateTime.now()),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      // MIDDLE SECTION (DYNAMIC)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon (Simple dynamic placeholder, we enhance this next)
                              Image.network(
                                'https://openweathermap.org/img/wn/${weatherData.iconCode}@2x.png',
                                height: 120, // Keep the size consistent
                                fit: BoxFit.cover,
                                // Optional: You can add a color filter to make the icon white
                                color: Colors.white,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  // Show a small spinner while the image loads
                                  return const SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white54,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              // Big Temperature
                              Text(
                                '${weatherData.temperature.round()}°C', // LIVE DATA (rounded for display)
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 96,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Weather Condition Text
                              Text(
                                weatherData.weatherCondition
                                    .toUpperCase(), // LIVE DATA
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

                      // BOTTOM DASHBOARD (DYNAMIC)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WeatherDetailItem(
                                icon: Icons.thermostat_outlined,
                                label: 'Feels Like',
                                value:
                                    '${weatherData.feelsLike.round()}°C', // LIVE DATA
                              ),
                              const VerticalDivider(
                                color: Colors.white54,
                                width: 20,
                                thickness: 1,
                              ),
                              WeatherDetailItem(
                                icon: Icons.air,
                                label: 'Wind Speed',
                                value:
                                    '${weatherData.windSpeed} km/h', // LIVE DATA
                              ),
                              const VerticalDivider(
                                color: Colors.white54,
                                width: 20,
                                thickness: 1,
                              ),
                              WeatherDetailItem(
                                icon: Icons.opacity,
                                label: 'Humidity',
                                value: '${weatherData.humidity}%', // LIVE DATA
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

        return const SizedBox.shrink();
      },
    );
  }
}
